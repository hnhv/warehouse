class Product < ApplicationRecord
  has_and_belongs_to_many :articles
  validates_presence_of :name, :price
end
