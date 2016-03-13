require_relative '../../../logger'

module EF2
  module Fresh
    module Filter
      class Every

        def initialize fresh_facade
          @fresh_facade = fresh_facade
        end

        def filter product_entry, asin_list

          if !product_entry.every_days
            return asin_list
          end

          every_limit  = Date.today.to_date - product_entry.every_days

          asin_list.each do |asin|
            product_model = @fresh_facade.get_product asin
            if product_model.last_ordered && product_model.last_ordered > every_limit
              EF2::Log.info "Skipping #{product_entry.entry.title} because #{product_model.name} ordered on #{product_model.last_ordered.strftime('%Y-%m-%d')}"
              return []
            end
          end

          return asin_list
        end
      end
    end
  end
end
