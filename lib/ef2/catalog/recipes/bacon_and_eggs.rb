module EF2
  module Catalog
    module Recipes
      class BaconAndEggs < EF2::Domain::Recipe

        title 'Bacon and Eggs'
        description 'Bacon and free-range eggs'

        product EF2::Catalog::Products::Bacon

        product EF2::Catalog::Products::Eggs do
          quantity 2
        end

      end
    end
  end
end