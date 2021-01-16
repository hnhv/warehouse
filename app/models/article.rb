class Article < ApplicationRecord
  has_and_belongs_to_many :products
  validates_presence_of :name, :quantity
end
