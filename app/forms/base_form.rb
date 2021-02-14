class BaseForm
  attr_reader :errors

  def initialize(params)
    raise 'Cannot Initialize this class' if self.class == BaseForm

    @params = assign_params(params.to_h)
    @errors = Error.new
    check_for_errors
  end

  def self.save(params)
    obj = new(params)
    obj.save
    obj
  end

  def save
    return false unless valid?

    set_parameters
    saved_to_db
  end

  def errors_hash
    @errors.errors
  end

  def valid?
    @errors.errors.blank?
  end

  protected

  def saved_to_db
    ## Add this method in child class
  end

  def assign_params
    ## Add this method in child class
  end

  def assign_attributes
    ## Add this method in child class
  end

  def check_for_errors
    @errors.add_hash(@params.errors.to_h) if @params.errors.to_h.present?
  end
end
