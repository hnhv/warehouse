namespace :import do
  require_relative '../importer'

  desc 'Load articles from inventory.json'
  task :inventory, [:path] => :environment do |task, args|
    inventory = JSON.parse(File.read(args[:path]))
    Importer.import_inventory(inventory)
  end

  desc 'Load products from products.json'
  task :products, [:path] => :environment do |task, args|
    products = JSON.parse(File.read(args[:path]))
    Importer.import_products(products)
  end
end
