module EF2
  module Domain
    class Recipe

      include Entry
      include ProductCollection

      def pick strategy, picker, quantity
        basket = Array.new

        quantity.times do
          products.each do |product|
            basket.concat product.pick strategy
          end
        end

        basket
      end

    end
  end
end