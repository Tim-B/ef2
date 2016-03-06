module EF2
  module Order
    class Fresh

      def initialize
        @picking_strategy = EF2::Picker::Strategy.new EF2::Picker::Random.new, EF2::Picker::First.new
      end

      def order list
        basket = list.pick @picking_strategy

        basket.each do |item|
          puts item
        end

      end

    end
  end
end