class Api::BaseController < ApplicationController
  respond_to :json
  include ApiExceptionHandler
  include ApiResponse

end
