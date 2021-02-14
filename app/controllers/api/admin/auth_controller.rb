class Api::Admin::AuthController < ApplicationController
  
  def refresh
    render json: {
      current_user: current_user,
      csrf_token: form_authenticity_token
    }
  end
end
