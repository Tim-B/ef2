require 'mechanize'
require_relative '../product_data'

class FreshFacade

  def initialize credentials_provider
    @credentials_provider = credentials_provider
    @mechanize = Mechanize.new do |agent|
      agent.user_agent_alias = 'Windows Chrome'
    end
    @mechanize.history_added = Proc.new { sleep 1 }

    @products = Hash.new
  end

  def get_product asin
    if @products.has_key? asin
      return @products[asin]
    end

    product = load_product asin
    @products[asin] = product
    product
  end

  def perform_login credentials, page, captcha=nil
    login_form = page.form_with(:name => 'signIn') do |f|
      f.email = credentials[:username]
      f.password = credentials[:password]

      if captcha
        f.guess = captcha
      end
    end

    after_login = login_form.submit

    if after_login.at('#message_error')
      raise 'Login failed, check your username and password.'
    end

    return after_login
  end

  def login
    @mechanize.get('https://fresh.amazon.com/')
    login = @mechanize.page.link_with(:text => 'Sign in').click

    credentials = @credentials_provider.get_credentials
    after_login = perform_login credentials, login

    if after_login.at('#ap_captcha_img')
      captcha_image = after_login.at("#ap_captcha_img img").attributes['src'].text
      captcha = @credentials_provider.get_captcha captcha_image
      perform_login credentials, after_login, captcha
    end

  end

  def load_product asin
    product_page = @mechanize.get("https://fresh.amazon.com/product?asin=#{asin}")

    product = ProductData.new
    product.asin = asin
    product.in_stock = true

    name = product_page.at('.buying h1')
    if name.nil
      product.name = name.text.strip
    end

    if product_page.at('.itemUnavailableText')
      product.in_stock = false
    end

    if product_page.at('.availabilityMessage')
      product.in_stock = false
    end

    if product.in_stock
      price_field = product_page.at('.itemPrice .value')
      if price_field
        product.price = price_field.text.strip.delete('$')
      end

      product.ratings = product_page.at('#numRated2MoonNBack').text.strip.delete('()')
      star_img = product_page.at('#2MoonNBack').attributes['src'].text
      matches = star_img.scan(/(.*)\/(.*?)\-star/)
      product.stars = matches[0][1]
    end

  end

  def order_product product
    product_page = @mechanize.get("https://fresh.amazon.com/product?asin=#{product}")
    product_page.form_with(:action => '/ShoppingCartView').submit
  end

end