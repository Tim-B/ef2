require_relative '../../../logger'

module EF2
  module Fresh
    module Filter
      class InStock

        def initialize fresh_facade
          @fresh_facade = fresh_facade
        end

        def filter product_entry, asin_list
          return_list = Array.new
          asin_list.each do |asin|
            product_model = @fresh_facade.get_product asin
            if product_model.in_stock
              return_list.push asin
            else
              EF2::Log.info "Filtering out #{asin} because it's out of stock"
            end
          end
          return return_list
        end

      end
    end
  end
end
