require_relative '../../lib/ef2/order/product_data'

class FreshFacadeMock

  def initialize config
    @ordered_products = Array.new
    @config = config
  end

  def get_product asin
    generate_product asin
  end

  def order_product asin
    @ordered_products.push asin
  end

  def get_ordered_products
    @ordered_products
  end

  private

  def generate_product asin
    product = ProductData.new
    product.asin = asin
    product.in_stock = in_stock asin
    product.name = generate_random_string
    product.price = 10
    product.last_ordered = last_ordered asin

    return product
  end

  def in_stock asin
    if @config[:out_of_stock] && @config[:out_of_stock].include?(asin)
      return false
    end
    return true
  end

  def last_ordered asin
    if @config[:last_ordered] && @config[:last_ordered].has_key?(asin)
      return Date.today - @config[:last_ordered][asin]
    end
    return nil
  end

  def generate_random_string
    (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  end

end