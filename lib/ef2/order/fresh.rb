require_relative 'picking_strategy'
require_relative 'fresh/pickers/first'
require_relative 'fresh/pickers/random'
require_relative '../order/fresh/fresh_facade'
require_relative '../progress'
require_relative 'fresh/filters/in_stock'

module EF2
  module Order
    class Fresh

      def initialize credentials_provider
        @credentials_provider = credentials_provider
        @picking_strategy = EF2::PickingStrategy.new EF2::Pickers::Fresh::Random.new, EF2::Pickers::Fresh::First.new
        @fresh_facade = FreshFacade.new credentials_provider

        @picking_strategy.set_filters(EF2::Fresh::Filter::InStock.new(@fresh_facade))
      end

      def order list
        @fresh_facade.login

        basket = list.pick @picking_strategy

        EF2::Progress.set_order_size basket.size

        basket.each do |item|
          @fresh_facade.order_product item
          EF2::Progress.put_order item
        end

        EF2::Progress.done
      end
    end
  end
end