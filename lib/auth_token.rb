# frozen_string_literal: true

# JWT AUTH token lib for API
class AuthToken
  def self.secret
    Rails.application.credentials[:api_hmac_secret]
  end

  def self.generate(user)
    exp = Time.now.to_i + 3600
    payload = {
      email: user.email,
      exp: exp,
      iss: 'pickemup_api'
    }
    { token: JWT.encode(payload, secret, 'HS512') }
  end

  def self.verify(token)
    return nil if token.blank?

    result = JWT.decode token, secret, true, { algorithm: 'HS512' }
    ApiUser.find_by(email: result.first['email'])
  end
end
