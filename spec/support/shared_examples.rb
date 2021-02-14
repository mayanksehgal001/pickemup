# frozen_string_literal: true

RETURNS_JSON_ERROR_RESPONSE = 'returns a JSON error response'
RETURNS_JSON_RESPONSE = 'returns a proper JSON response'
INVALID_PARAMS = 'handles an invalid param'
RESPONSE_STATUS_400 = '400 response status'
RESPONSE_STATUS_201 = '201 response status'
RESPONSE_STATUS_200 = '200 response status'
STATUS_401 = '401 status'
STATUS_400 = '400 status'
DATE_FORMAT = '%FT%T.%LZ'
STATUS_404 = '404 status'
STATUS_422 = '422 status'
STATUS_204 = '204 status'

RSpec.shared_examples 'handles missing credentials' do
  context 'when no user credentials are provided' do
    it_behaves_like STATUS_401

    # it RETURNS_JSON_ERROR_RESPONSE do
    #   hash = JSON.parse(response.body).deep_symbolize_keys!
    #
    #   expect(hash).to eql(errors: ['Nil JSON web token'])
    # end
  end
end

RSpec.shared_examples INVALID_PARAMS do |expected_errors|
  it_behaves_like STATUS_400

  it RETURNS_JSON_ERROR_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(errors: expected_errors)
  end
end

RSpec.shared_examples 'handles a bad request' do |expected_errors|
  it_behaves_like STATUS_400

  it 'returns a JSON error response' do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(errors: expected_errors)
  end
end

RSpec.shared_examples '404 response status' do |expected_errors|
  it_behaves_like STATUS_404

  it RETURNS_JSON_ERROR_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(errors: expected_errors)
  end
end

RSpec.shared_examples '401 response status' do |expected_errors|
  it_behaves_like STATUS_401

  it RETURNS_JSON_ERROR_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(errors: expected_errors)
  end
end

RSpec.shared_examples '400 response status' do |expected_errors|
  it_behaves_like STATUS_400

  it RETURNS_JSON_ERROR_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(errors: expected_errors)
  end
end

RSpec.shared_examples 'bad request' do
  it 'returns a status of 400' do
    expect(response).to have_http_status(400)
  end
end

RSpec.shared_examples RESPONSE_STATUS_200 do
  it 'returns a status of 200' do
    expect(response).to have_http_status(200)
  end
end

RSpec.shared_examples RESPONSE_STATUS_201 do
  it 'returns a status of 201' do
    expect(response).to have_http_status(201)
  end
end

RSpec.shared_examples STATUS_400 do
  it 'returns a status of 400' do
    expect(response).to have_http_status(400)
  end
end

RSpec.shared_examples STATUS_401 do
  it 'returns a status of 401' do
    expect(response).to have_http_status(401)
  end
end

RSpec.shared_examples STATUS_404 do
  it 'returns a status of 404' do
    expect(response).to have_http_status(404)
  end
end

RSpec.shared_examples STATUS_422 do
  it 'returns a status of 404' do
    expect(response).to have_http_status(422)
  end
end

RSpec.shared_examples STATUS_204 do
  it 'returns a status of 204' do
    expect(response).to have_http_status(204)
  end
end

RSpec.shared_examples 'returns proper paginated response' do
  let(:subject) { described_class.new(attributes).response }

  context 'when there are no records' do
    let(:per_page) { 4 }
    let(:number_of_records) { 0 }

    it { is_expected.to eql({}) }
  end

  context 'when number of records is less than one page' do
    let(:number_of_records) { 2 }
    let(:per_page) { 4 }
    let(:expected_records) { records }

    it do
      is_expected.to eql(
        page: 1,
        limit: per_page,
        result: expected_results,
        total: number_of_records
      )
    end
  end

  context 'when number of records is more than one page' do
    let(:number_of_records) { 10 }
    let(:per_page) { 4 }

    context 'when page is one' do
      let(:expected_records) { records.limit(per_page) }

      it do
        is_expected.to eql(
          limit: per_page,
          page: page,
          result: expected_results,
          total: number_of_records
        )
      end
    end

    context 'when page is two' do
      let(:page) { 2 }
      let(:expected_records) { records.offset(per_page).limit(per_page) }

      it do
        is_expected.to eql(
          limit: per_page,
          page: page,
          result: expected_results,
          total: number_of_records
        )
      end
    end
  end
end

RSpec.shared_examples 'handles invalid page params' do
  context 'when there are invalid params' do
    let(:params) { { page: 'one' } }

    it_behaves_like(
      INVALID_PARAMS, ["'one' is not a valid Integer"]
    )
  end
end

RSpec.shared_examples '200 response status with message' do |expected_msg|
  it_behaves_like RESPONSE_STATUS_200

  it RETURNS_JSON_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(status: expected_msg)
  end
end

RSpec.shared_examples '201 response status with message' do |expected_msg|
  it_behaves_like RESPONSE_STATUS_201

  it RETURNS_JSON_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!

    expect(hash).to eql(status: expected_msg)
  end
end

RSpec.shared_examples '404 record not found' do |expected_msg|
  it_behaves_like STATUS_404

  it RETURNS_JSON_ERROR_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!
    expect(hash).to eql(errors: expected_msg)
  end
end

RSpec.shared_examples '422 unprocessable entity' do |expected_msg|
  it_behaves_like STATUS_422

  it RETURNS_JSON_ERROR_RESPONSE do
    hash = JSON.parse(response.body).deep_symbolize_keys!
    expect(hash).to eql(errors: expected_msg)
  end
end
