module EF2
  module Picker
    class Strategy

      def initialize default, *strategies
        @strategies = Hash.new(default)

        strategies.each do |strategy|
          @strategies.store strategy.id, strategy
        end
      end

      def pick picker, options, quantity
        picked = @strategies[picker].pick options, quantity
        picked
      end

    end
  end
end