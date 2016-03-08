require 'mechanize'
require_relative '../pickers/strategy'
require_relative '../pickers/fresh/first'
require_relative '../pickers/fresh/random'

module EF2
  module Order
    class Fresh

      def initialize
        @picking_strategy = EF2::Pickers::Strategy.new EF2::Pickers::Fresh::Random.new, EF2::Pickers::Fresh::First.new

        @mechanize = Mechanize.new do |agent|
          agent.user_agent_alias = 'Windows Chrome'
        end
        @mechanize.history_added = Proc.new { sleep 1 }
      end

      def order list
        login

        basket = list.pick @picking_strategy

        basket.each do |item|
          order_product item
        end
      end

      def login
        raise "email environment variable missing" if ENV['email'].nil?
        raise "password environment variable missing" if ENV['password'].nil?
        home = @mechanize.get('https://fresh.amazon.com/')
        login = @mechanize.page.link_with(:text => 'Sign in').click

        login.form_with(:name => 'signIn') do |f|
          f.email = ENV['email']
          f.password = ENV['password']
        end.submit
      end

      def order_product sku
        puts "Ordering #{sku}"
        product_page = @mechanize.get("https://fresh.amazon.com/product?asin=#{sku}")
        product_page.form_with(:action => '/ShoppingCartView').submit
      end

    end
  end
end