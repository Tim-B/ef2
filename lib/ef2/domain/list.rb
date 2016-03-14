require_relative 'product_collection'
require_relative 'recipe_collection'
require_relative '../order/fresh'
require_relative '../logger'
require_relative '../progress'

module EF2
  module Domain
    class List
      include ProductCollection
      include RecipeCollection

      def read_list list
        cat_dir = File.dirname(list) + '/catalog'
        EF2::Log.info "Loading list #{list}"
        load_catalog cat_dir
        instance_eval(File.read(list))
      end

      def process_list &block
        instance_eval &block
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

      def form order_handler
        #print_cart
        order_handler.order self
      end

      def load_catalog cat_dir
        EF2::Domain::Product.load_dir(cat_dir + '/products')
        EF2::Domain::Recipe.load_dir(cat_dir + '/recipes')
      end

      def pick product_picker
        basket = Array.new

        EF2::Progress.start_stage recipes.size + products.size

        recipes.each do |recipe|
          EF2::Progress.stage_progress "Picking #{recipe.entry.title}"
          basket.concat recipe.pick product_picker
        end

        products.each do |product|
          EF2::Progress.stage_progress "Picking #{product.entry.title}"
          basket.concat product.pick product_picker
        end

        return basket
      end

    end
  end
end