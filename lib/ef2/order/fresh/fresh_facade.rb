require 'mechanize'
require 'Date'
require_relative '../product_data'
require_relative '../../logger'
require_relative '../../progress'

class FreshFacade

  def initialize credentials_provider
    @credentials_provider = credentials_provider
    @mechanize = Mechanize.new do |agent|
      agent.user_agent_alias = 'Windows Chrome'
    end
    @mechanize.history_added = Proc.new { sleep 1 }

    @products = Hash.new
    login
    @order_history = get_product_history
  end

  def get_product asin
    if @products.has_key? asin
      return @products[asin]
    end

    product = load_product asin
    @products[asin] = product
    product
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

  def order_product product
    product_page = @mechanize.get("https://fresh.amazon.com/product?asin=#{product}")
    product_page.form_with(:action => '/ShoppingCartView').submit
  end

  private

  def load_product asin
    product_page = @mechanize.get("https://fresh.amazon.com/product?asin=#{asin}")

    product = ProductData.new
    product.asin = asin
    product.in_stock = true

    name = product_page.at('.buying h1')
    if name
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

    product.last_ordered = get_last_ordered asin

    return product
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

  def get_last_ordered asin
    @order_history[asin]
  end

  def get_product_history
    product_history = Hash.new
    history_page = @mechanize.get("https://fresh.amazon.com/AllOrders")
    rows = history_page.search('#yourOrders tbody tr')
    EF2::Progress.start_stage rows.size
    rows.each do |row|
      date_col = row.search('td')[1]
      if date_col
        EF2::Log.info "Loading order history for order #{row.search('td')[0].text.strip}"
        EF2::Progress.stage_progress "Loading order history for #{row.search('td')[0].text.strip}"
        order_date = Date.parse(date_col.text.strip)
        details_form = form = Mechanize::Form.new row.at('form'), @mechanize, history_page
        order_details = details_form.submit
        asins = get_products_from_order order_details

        asins.each do |asin|
          if product_history.has_key? asin
            previous_date = product_history[asin]
            if previous_date < order_date
              product_history.store asin, order_date
            end
          else
            product_history.store asin, order_date
          end
        end
      end
    end

    product_history
  end

  def get_products_from_order page
    products = Array.new
    page.search('.product a').each do |product|
      asin = product.attributes['href'].text.strip
      asin.slice! 'https://fresh.amazon.com/product?asin='
      products.push asin
    end
    return products
  end

end