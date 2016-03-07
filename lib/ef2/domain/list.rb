module EF2
  module Domain
    class List
      include ProductCollection
      include RecipeCollection

      def self.order order
        @@order = order
      end

      def print_cart
        recipes.each do |recipe|
          puts 'Recipes:'
          puts recipe.entry.title
          recipe.entry.products.each do |product|
            puts "- #{product.entry.title} x #{product.quantity}"
          end
        end

        puts 'Products:'
        products.each do |product|
          puts "* #{product.entry.title} x #{product.quantity}"
        end
      end

      def order
        @@order.order self
      end

      def pick strategy
        basket = Array.new

        recipes.each do |recipe|
          basket.concat recipe.pick strategy
        end

        products.each do |product|
          basket.concat product.pick(strategy)
        end

        basket
      end

    end
  end
end