module EF2
  module Domain
    class Product

      include Entry
      include SKUCollection

      def pick strategy, picker, quantity
        strategy.pick picker, skus, quantity
      end

    end
  end
end