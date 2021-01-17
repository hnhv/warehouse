require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many(:articles) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
    
  describe '#quantity_available' do
    let!(:product) { FactoryBot.create(:product, name: 'Dining Chair') }

    before do
      FactoryBot.create(:product_article, product: product, article: article1, quantity: 4)
      FactoryBot.create(:product_article, product: product, article: article2, quantity: 8)
      FactoryBot.create(:product_article, product: product, article: article3, quantity: 1)
    end

    context 'all articles for product are availalbe' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 12) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      it 'a quantity of 2 is available' do
        expect(product.quantity_available).to eq 2
      end
    end

    context 'not all articles for product are available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 3) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      it 'a quanitity of 0 is available' do
        expect(product.quantity_available).to eq 0
      end
    end
  end
end
