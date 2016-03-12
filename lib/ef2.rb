require 'thor'
require_relative 'ef2/version'
require_relative 'ef2/domain/list'
require_relative 'ef2/domain/product'
require_relative 'ef2/domain/recipe'
require_relative 'ef2/order/stdin_credentials_supplier'

class EF2CLI < Thor

  class_option :verbose, :type => :boolean, :aliases => '-v'

  desc 'form LIST', 'Forms an order from a supplied LIST and orders it from Amazon Fresh'
  def form(list_file)
    credentials_provider = STDINCredentialsSupplier.new self
    order_handler = EF2::Order::Fresh.new credentials_provider

    list = EF2::Domain::List.new
    list.read_list Dir.pwd + '/' + list_file
    list.form order_handler
  end
end

