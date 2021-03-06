require 'rails_helper'

RSpec.describe "Houses", type: :request do
	let!(:owner) { FactoryBot.create(:owner) }
  let!(:houses) { FactoryBot.create_list(:house, 20, owner_id: owner.id) }
  let(:house_id) { houses.first.id }

	describe 'GET /owners/owner_id/houses/:id' do
    before { get "/owners/#{owner.id}/houses/#{house_id}" }

    context 'when the record exists' do
      it 'returns the contact person data' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(house_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:house_id) { 666 }

      it 'returns a not found message' do
        expect(response.body).to match(/record not found/)
      end
    end
  end

  describe 'GET /owners/:owner_id/houses/:id' do
    before { get "/owners/#{owner.id}/houses/#{house_id}" }

    context 'when the house exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the house' do
        expect(JSON.parse(response.body)['id']).to eq(house_id)
      end
    end

    context 'when the house does not exist' do
      let(:house_id) { 666 }

      it 'returns a not found message' do
        expect(response.body).to match(/record not found/)
      end
    end
  end

	describe 'POST /owners/owner_id/houses' do
    let(:house_attributes) { {
                                category: 'sale',
                                size: 85,
                                rooms: 3,
                                bathrooms: 1,
                                price: 650,
																link: "https://www.theworldsworstwebsiteever.com/",
                                owner_id: owner.id
                            } }

    context 'when the request is valid' do
      before { post "/owners/#{owner.id}/houses", params: house_attributes }
			
      it 'creates a house record' do
        expect(JSON.parse(response.body)["category"]).to eq(house_attributes[:category])
        expect(JSON.parse(response.body)["size"]).to eq(house_attributes[:size])
        expect(JSON.parse(response.body)["rooms"]).to eq(house_attributes[:rooms])
        expect(JSON.parse(response.body)["bathrooms"]).to eq(house_attributes[:bathrooms])
        expect(JSON.parse(response.body)["price"]).to eq(house_attributes[:price])
				expect(JSON.parse(response.body)["link"]).to eq(house_attributes[:link])
        expect(JSON.parse(response.body)["owner_id"]).to eq(house_attributes[:owner_id])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

	describe 'PUT /owners/:owner_id/houses/:id' do
    let(:params) { { price: 150000 } }

    before { put "/owners/#{owner.id}/houses/#{house_id}", params: params }

    context 'when house exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the house' do
        updated_house = House.find(house_id)
        expect(updated_house.price).to match(150000)
      end
    end

    context 'when the house does not exist' do
      let(:house_id) { 666 }

      it 'returns a not found message' do
        expect(response.body).to match(/record not found/)
      end
    end
  end

	describe 'DELETE /owners/:id' do
    before { delete "/owners/#{owner.id}/houses/#{house_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
