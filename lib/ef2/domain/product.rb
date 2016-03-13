require_relative 'entry'
require_relative 'asin_collection'
require_relative 'catalog_loader'

module EF2
  module Domain
    class Product

      include Entry
      include ASINCollection
      include CatalogLoader

      def pick strategy, picker, entry, quantity
        picked = strategy.pick picker, entry, asins, quantity
        EF2::Log.info "Picked #{picked} for product #{title} using strategy #{picker}"
        picked
      end

    end
  end
end