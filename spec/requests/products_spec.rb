require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:products) { create_list(:product, 3) }
  let(:product_id) { products.first.id }

  describe 'GET /products' do
    before { get '/products' }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /products/:id' do
    before { get "/products/#{product_id}" }

    context 'when the record exists' do
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'has property quantity_available' do
        expect(json).to have_key 'quantity_available'
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Product")
      end
    end
  end

  describe 'POST /products/:id/remove' do
    let!(:product) { FactoryBot.create(:product, name: 'Dining Chair') }

    before do
      FactoryBot.create(:product_article, product: product, article: article1, quantity: 4)
      FactoryBot.create(:product_article, product: product, article: article2, quantity: 8)
      FactoryBot.create(:product_article, product: product, article: article3, quantity: 1)
    end

    context 'when sufficient stock is available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 12) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      let!(:original_quanitity_available) { product.quantity_available }

      it 'returns status code 200, reduces quantity by 1' do
        post "/products/#{product.id}/remove"
        expect(response).to have_http_status(200)
        expect(product.reload.quantity_available).to eq(original_quanitity_available - 1)
      end
    end

    context 'when sufficient stock is not available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 12) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 2) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      before do
        post "/products/#{product.id}/remove"
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(409)
      end

      it 'returns a insufficient stock message' do
        expect(response.body).to include('Insufficient stock available')
      end
    end
  end
end
