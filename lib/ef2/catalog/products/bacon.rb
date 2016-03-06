module EF2
  module Catalog
    module Products
      class Bacon < EF2::Domain::Product

        title 'Bacon'
        description 'Crispy crispy bacon'

        sku 'B006T88XUQ'
        sku 'B000R4D8RQ'
        sku 'B000XTGRSW'

      end
    end
  end
end