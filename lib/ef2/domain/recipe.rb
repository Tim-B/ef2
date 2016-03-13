require_relative 'entry'
require_relative 'product_collection'
require_relative 'catalog_loader'

module EF2
  module Domain
    class Recipe

      include Entry
      include ProductCollection
      include CatalogLoader

      def pick strategy, picker, entry, quantity
        basket = Array.new

        quantity.times do
          products.each do |product|
            basket.concat product.pick strategy
          end
        end

        return basket
      end

    end
  end
end