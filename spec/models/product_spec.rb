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

    context 'sufficient quantity of all articles for product are availalbe' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 12) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      it 'returns quantity of products that can be suplied' do
        expect(product.quantity_available).to eq 2
      end
    end

    context 'not all articles for product are available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 3) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      it 'returns quanitity of 0' do
        expect(product.quantity_available).to eq 0
      end
    end
  end

  describe '#remove!' do
    let!(:product) { FactoryBot.create(:product, name: 'Dining Chair') }

    before do
      FactoryBot.create(:product_article, product: product, article: article1, quantity: 4)
      FactoryBot.create(:product_article, product: product, article: article2, quantity: 8)
      FactoryBot.create(:product_article, product: product, article: article3, quantity: 1)
    end

    context 'sufficient stock of articles available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 12) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      before do
        product.remove!
      end

      it 'reduces available quantity of each required article' do
        expect(article1.reload.quantity).to eq 8
        expect(article2.reload.quantity).to eq 9
        expect(article3.reload.quantity).to eq 1
      end
    end

    context 'insufficient stock of articles available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 3) }
      let!(:article2) { FactoryBot.create(:article, name: 'Screw', quantity: 17) }
      let!(:article3) { FactoryBot.create(:article, name: 'Seat', quantity: 2) }

      it 'raises an exception' do
        expect { product.remove! }.to raise_error(Product::InsufficientStock)
      end
    end
  end
end
