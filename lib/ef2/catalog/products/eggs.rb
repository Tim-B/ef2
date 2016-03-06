module EF2
  module Catalog
    module Products
      class Eggs < EF2::Domain::Product

        title 'Eggs'
        description 'Free range eggs'

        sku 'B003JVMZD2'
        sku 'B00O9PLAO2'

      end
    end
  end
end