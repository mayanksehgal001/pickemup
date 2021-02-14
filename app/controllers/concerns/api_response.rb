module ApiResponse
  def json_response(object, status = :ok, serializer = nil, options = {})
    render json: serialized_response(object, serializer, options), status: status
  end

  def handle_response(data, status, options = {})
    json_response(data, status, serializer_class, options)
  end

  def error_response(errors, status = :unprocessable_entity)
    json_response({ errors: errors }, status)
  end

  def pagination_meta_info(collection)
    {
      meta: {
        pagination: {
          current_page: collection.current_page,
          prev_page: collection.prev_page,
          next_page: collection.next_page,
          total_pages: collection.total_pages,
          per_page: per_page_value,
          count: collection.total_count
        }
      }
    }
  end

  protected

  def serializer_class
    "#{controller_name.classify}Serializer".constantize
  end

  def per_page_value
    params[:per_page] ? params[:per_page].to_i : 10
  end

  def serialized_response(obj, serializer, options)
    if serializer.present?
      serialized_data(obj, serializer, params[:include], options)
    else
      obj
    end
  end

  def serialized_data(obj, serializer, include_params, options = {})
    included_array = included_assoc(include_params, options[:default_include])
    serializer.new(
      obj,
      options.merge(
        {
          fields: fields_hash,
          include: included_array,
          params: { include: included_array }
        }
      )
    ).serialized_json
  end

  def included_assoc(include_params, default_include = [])
    include_array = include_params || []
    include_array.push(default_include).flatten.uniq
  end

  def fields_hash
    params[:fields].as_json
  end
end
