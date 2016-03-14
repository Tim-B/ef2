require_relative '../../lib/ef2/order/fresh'
require_relative '../../lib/ef2/progress'
require_relative 'fresh_facade_mock'

class ListHarness

  def self.run_list(config={}, &block)
    facade_mock = FreshFacadeMock.new config
    order_handler = EF2::Order::Fresh.new facade_mock

    list = EF2::Domain::List.new
    list.load_catalog File.dirname(__FILE__) + '/../fixtures/catalog'
    list.process_list &block
    list.form order_handler

    return facade_mock.get_ordered_products
  end

end