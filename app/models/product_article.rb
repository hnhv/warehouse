class ProductArticle < ApplicationRecord
  belongs_to :product
  belongs_to :article
  validates_presence_of :quantity
end
