class Api::AuthenticateController < ApplicationController
  include ApiResponse
  skip_before_action :authenticate_user!

  def generate_token
    return head(:bad_request) if !request.format.json? && !request.format.xml?
    return head(:bad_request) if params[:key].blank? || params[:secret].blank?

    @api_user = ApiUser.find_by(
      'users.email= ? AND users.encrypted_key = ?',
      params[:key], ApiUser.encrypt_api_secret(params[:secret])
    )

    return head(:unauthorized) if @api_user.blank?

    auth = AuthToken.generate(@api_user)
    json_response({ token: auth[:token] }, 200)
  end
end
