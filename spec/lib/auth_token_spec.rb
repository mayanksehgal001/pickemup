# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthToken do
  let(:secret) { Rails.application.credentials[:api_hmac_secret] }
  let(:user) { FactoryBot.create(:api_user) }
  let(:token) { AuthToken.generate(user) }
  let(:staff) { FactoryBot.create(:staff) }

  context 'JWT token' do
    it 'generates a JWT and verifies if the generated token was correct' do
      expect(AuthToken.verify(token[:token])).to eq(user)
    end
  end
end
