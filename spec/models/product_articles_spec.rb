require 'rails_helper'

RSpec.describe ProductArticle, type: :model do
  it { should belong_to(:article) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:quantity) }

  describe '#stock_available_for_products' do
    let(:product) { FactoryBot.create(:product, name: 'Dining Chair') }
    let(:product_article) { FactoryBot.create(:product_article, product: product, article: article1, quantity: 4) }

    context 'enough articles are available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 14) }

      it 'shows product_article as available' do
        expect(product_article.stock_available_for_products).to eq 3
      end
    end

    context 'not enough articles are available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 2) }

      it 'shows product_article as available' do
        expect(product_article.stock_available_for_products).to eq 0
      end
    end

  
  end
end
