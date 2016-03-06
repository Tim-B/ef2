require 'ef2/version'
require 'ef2/domain/entry'
require 'ef2/domain/sku_collection'
require 'ef2/domain/collection_entry'
require 'ef2/domain/product_collection'
require 'ef2/domain/recipe_collection'
require 'ef2/domain/product'
require 'ef2/domain/recipe'
require 'ef2/domain/list'

Dir[File.dirname(__FILE__) + '/ef2/catalog/products/*.rb'].each do |file|
  require file
end

Dir[File.dirname(__FILE__) + '/ef2/catalog/recipes/*.rb'].each do |file|
  require file
end

Dir[File.dirname(__FILE__) + '/ef2/picker/*.rb'].each do |file|
  require file
end

Dir[File.dirname(__FILE__) + '/ef2/order/*.rb'].each do |file|
  require file
end

module EF2

end
