# frozen_string_literal: true

# JWT AUTH token lib for API
module JwtToken
  def self.generate(data = {})
    exp = Time.now.to_i + 3600

    payload = {
      data: data,
      exp: exp,
      iss: 'pickemup_api'
    }
    JWT.encode(payload, AuthToken.secret, 'HS512')
  end

  def self.verify(token)
    return nil if token.blank?

    JWT.decode token, AuthToken.secret, true, { algorithm: 'HS512' }
  end
end
