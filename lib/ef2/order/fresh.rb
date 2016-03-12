require_relative '../pickers/strategy'
require_relative '../pickers/fresh/first'
require_relative '../pickers/fresh/random'
require_relative '../order/fresh/fresh_facade'

module EF2
  module Order
    class Fresh

      def initialize credentials_provider
        @credentials_provider = credentials_provider
        @picking_strategy = EF2::Pickers::Strategy.new EF2::Pickers::Fresh::Random.new, EF2::Pickers::Fresh::First.new
        @fresh_facade = FreshFacade.new credentials_provider
      end

      def order list
        @fresh_facade.login

        basket = list.pick @picking_strategy

        basket.each do |item|
          @fresh_facade.order_product item
        end
      end

    end
  end
end