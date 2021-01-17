require 'rails_helper'

RSpec.describe ProductArticle, type: :model do
  it { should belong_to(:article) }
  it { should belong_to(:product) }
  it { should validate_presence_of(:quantity) }

  describe '#available?' do
    let(:product) { FactoryBot.create(:product, name: 'Dining Chair') }
    let(:product_article) { FactoryBot.create(:product_article, product: product, article: article1, quantity: 4) }

    context 'enough articles are available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 12) }

      it 'shows product_article as available' do
        expect(product_article.available?).to be true
      end
    end

    context 'not enough articles are available' do
      let!(:article1) { FactoryBot.create(:article, name: 'Leg', quantity: 2) }

      it 'shows product_article as available' do
        expect(product_article.available?).to be false
      end
    end
  end
end
