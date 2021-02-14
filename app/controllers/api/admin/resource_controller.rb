class Api::Admin::ResourceController < Api::BaseController
  before_action :run_callbacks!
  before_action :perform_schema_validation, only: %i[create update]

  def index
    handle_response(@collection, :ok, pagination_meta_info(@collection))
  end

  def create
    @object.attributes = permitted_create_params
    if @object.save
      handle_response(@object, :created)
    else
      error_response(@object.errors)
    end
  end

  def update
    if @object.update(permitted_update_params)
      handle_response(@object, :ok)
    else
      error_response(@object.errors)
    end
  end

  def show
    handle_response(@object, :ok)
  end

  def destroy
    if @object.destroy
      head :no_content
    else
      error_response(@object.errors)
    end
  end

  private

  def load_resource
    if member_action?
      @object = load_resource_instance
      instance_variable_set("@#{resource_name}", @object)
    else
      collection
    end
  end

  def load_parent
    parent
  end

  def collection
    if parent_data.present?
      @collection = parent.send(collection_name)
    else
      @collection =model_class
    end
    @collection = search_query if params[:q].present?
    @collection = @collection.ransack(params[:filter]).result
    @collection = sort_query if params[:sort].present?
    @collection = @collection.page(params[:page]).per(per_page_value)
    instance_variable_set("@#{controller_name}", @collection)
  end

  def parent
    return if parent_data.blank?

    @parent ||= parent_data[:model_class]
                .send(:find_by!, parent_data[:find_by].to_s => params["#{parent_data[:model_name]}_id"])
    instance_variable_set("@#{parent_data[:model_name]}", @parent)
  end

  class << self
    attr_accessor :parent_data, :extra_collection_actions, :extra_new_actions, :perform_schema_validation

    def belongs_to(model_name, options = {})
      @parent_data ||= {}
      @parent_data[:model_name] = model_name
      @parent_data[:model_class] = model_name.to_s.classify.constantize
      @parent_data[:find_by] = options[:find_by] || :id
    end

    def add_collection_actions(action_names = [])
      @extra_collection_actions = action_names
    end

    def add_new_actions(action_names = [])
      @extra_new_actions = action_names
    end

    def validate_schema(value = false)
      @perform_schema_validation = value
    end
  end

  def model_name
    resource_name.classify
  end

  def run_callbacks!
    load_resource
  end

  def resource_name
    controller_name.singularize
  end

  def model_class
    model_name.constantize
  end

  def search_query
    search_columns = model_class.search_columns
    query_arr = []
    search_columns.each do |col|
      query_arr << "#{col} ILIKE :q"
    end
    @collection.where([query_arr.join(' OR '), { q: "%#{params[:q]}%" }])
  end

  def collection_actions
    [:index] + extra_collection_actions
  end

  def member_action?
    !collection_actions.include? action
  end

  def action
    params[:action].to_sym
  end

  def new_actions
    %i[new create] + extra_new_actions
  end

  def load_resource_instance
    if new_actions.include?(action)
      build_resource
    else
      find_resource
    end
  end

  def build_resource
    if parent_data.present?
      parent.send(collection_name).new
    else
      model_class.new
    end
  end

  # NOTE: extra query to find parent first
  def find_resource
    if parent_data.present?
      parent.send(collection_name).find(params[:id])
    else
      model_class.find_by!(account_id: current_account.id, id: params[:id])
    end
  end

  def parent_data
    self.class.parent_data
  end

  def collection_name
    controller_name
  end

  def extra_collection_actions
    self.class.extra_collection_actions || []
  end

  def extra_new_actions
    self.class.extra_new_actions || []
  end

  def permitted_resource_params
    if params[resource_name.to_sym].present?
      params.require(resource_name.to_sym).permit!
    else
      ActionController::Parameters.new
    end
  end

  def permitted_create_params
    permitted_resource_params
  end

  def permitted_update_params
    permitted_resource_params
  end

  def sort_query
    if params[:sort].present?
      sort_array = params[:sort]
      sort_query = []

      sort_array.each do |sort|
        order = 'asc'
        field = sort
        if sort.start_with?('-')
          field = sort.gsub('-', '')
          order = 'desc'
        end
        sort_query << "#{field} #{order}"
      end

      order_str = sort_query.join(', ')
      @collection = @collection.order(order_str)
    end

    @collection = @collection.order(default_sort.join(', '))
  end

  def default_sort
    # add this method to child classes
    []
  end

  def perform_schema_validation
    return unless self.class.perform_schema_validation

    schema = "#{model_name}Schema::#{action_name.classify}".constantize
    hsh = self.send("permitted_#{action_name}_params").to_h
    result = schema.call(hsh)
    error_response(result.errors.to_h) if result.errors.present?
  end
end
