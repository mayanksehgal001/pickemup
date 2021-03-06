module ApiExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ errors: { message: e.message } }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ errors: { message: e.message } }, :unprocessable_entity)
    end

    rescue_from ActionController::UnpermittedParameters do |exception|
      render json: { errors:  { unknown_parameters: exception.params } }, status: :bad_request
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      json_response({ errors: { message: e.message } }, :unauthorized)
    end

    rescue_from ArgumentError do |e|
      json_response({ errors: { message: error_formatting(e.message) } }, :bad_request)
    end

    rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
      error = {}
      error[parameter_missing_exception.param] = ['parameter is required']
      render json: { errors: error }, status: :unprocessable_entity
    end

    def error_formatting(msg)
      msg.gsub('Serializer', '')
    end
  end
end
