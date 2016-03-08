require_relative 'entry'
require_relative 'sku_collection'
require_relative 'catalog_loader'

module EF2
  module Domain
    class Product

      include Entry
      include SKUCollection
      include CatalogLoader

      def pick strategy, picker, quantity
        strategy.pick picker, skus, quantity
      end

    end
  end
end