require_relative '../../../logger'

module EF2
  module Fresh
    module Filter
      class InStock

        def initialize fresh_facade
          @fresh_facade = fresh_facade
        end

        def filter product_list
          return_list = Array.new
          product_list.each do |product|
            product_model = @fresh_facade.get_product product
            if product_model.in_stock
              return_list.push product
            else
              EF2::Log.info "Filtering out #{product} because it's out of stock"
            end
          end
          return return_list
        end

      end
    end
  end
end
