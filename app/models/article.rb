class Article < ApplicationRecord
  has_many :product_articles
  has_many :products, through: :product_articles
  validates_presence_of :name, :quantity

  def remove_stock!(quantity)
    self.quantity -= quantity
    save!
  end
end
