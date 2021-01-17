class Importer
  def self.import_inventory(inventory)
    inventory.dig('inventory').each do |article|
      Article.create!(id: article['art_id'],
                      name: article['name'],
                      quantity: article['stock'])
    end
  end

  def self.import_products(product_definitions)
    product_definitions['products'].each do |product_definition|
      product = Product.create!(name: product_definition['name'])
      product_definition['contain_articles'].each do |article_defintion|
        article = Article.find(article_defintion['art_id'])
        ProductArticle.create(product: product,
                              article: article,
                              quantity: article_defintion['amount_of'])
      end
    end
  end
end
