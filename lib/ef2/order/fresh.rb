require_relative 'picking_strategy'
require_relative 'fresh/pickers/first'
require_relative 'fresh/pickers/random'
require_relative 'fresh/filters/in_stock'
require_relative 'fresh/filters/every'
require_relative '../order/fresh/fresh_facade'
require_relative '../progress'

module EF2
  module Order
    class Fresh

      def initialize(credentials_provider)
        @credentials_provider = credentials_provider
        @product_picker = EF2::PickingStrategy.new EF2::Pickers::Fresh::First.new, EF2::Pickers::Fresh::Random.new

        EF2::Progress.set_stages 3

        @fresh_facade = FreshFacade.new credentials_provider
        @product_picker.set_filters(
            EF2::Fresh::Filter::Every.new(@fresh_facade),
            EF2::Fresh::Filter::InStock.new(@fresh_facade)
        )
      end

      def order list
        basket = list.pick @product_picker
        pp basket

        EF2::Progress.start_stage(basket.size)

        basket.each do |item|
          EF2::Progress.stage_progress "Ordering #{item}"
          @fresh_facade.order_product item
        end

        EF2::Progress.done
      end
    end
  end
end