class ProductArticle < ApplicationRecord
  belongs_to :product
  belongs_to :article
  validates_presence_of :quantity

  def stock_available_for_products
    article.quantity / quantity
  end
end
