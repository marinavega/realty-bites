require 'rails_helper'

RSpec.describe "Owners", type: :request do
  # initialize test data 
  let!(:owners)   { FactoryBot.create_list(:owner, 10) }
  let(:owner_id) { owners.first.id }

  describe 'GET /owners' do
    before { get '/owners' }

    it 'returns contact people data' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /owners/:id' do
    before { get "/owners/#{owner_id}" }

    context 'when the record exists' do
      it 'returns the contact person data' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(owner_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:owner_id) { 666 }

      it 'returns a not found message' do
        expect(response.body).to match(/record not found/)
      end
    end
  end

  describe 'POST /owners' do
    let(:owner_attributes) { {
                                        category: "independent",
                                        name: Faker::Name.name,
                                        email: Faker::Internet.email,
                                        phone: Faker::PhoneNumber.phone_number 
                                    } }

    context 'when the request is valid' do
      before { post '/owners', params: owner_attributes }

      it 'creates a contact person record' do
        expect(JSON.parse(response.body)["category"]).to eq(owner_attributes[:category])
        expect(JSON.parse(response.body)["name"]).to eq(owner_attributes[:name])
        expect(JSON.parse(response.body)["email"]).to eq(owner_attributes[:email])
        expect(JSON.parse(response.body)["phone"]).to eq(owner_attributes[:phone])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT /owners/:id' do
    let(:owners_attributes) { { name: 'Inmobhilario' } }

    context 'when the record exists' do
      before { put "/owners/#{owner_id}", params: owners_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      let(:owner_id) { 666 }
      before { put "/owners/#{owner_id}", params: owners_attributes }

      it 'returns a not found message' do
        expect(response.body).to match(/record not found/)
      end
    end
  end

  describe 'DELETE /owners/:id' do
    before { delete "/owners/#{owner_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
