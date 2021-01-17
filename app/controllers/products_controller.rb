class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :remove]

  # GET /products
  def index
    @products = Product.all
    json_response(@products)
  end

  # GET /products/:id
  def show
    json_response(@product)
  end

  # POST /products/:id/remove
  def remove
    @product.remove!
    json_response(@product)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
