require_relative 'product_entry'
require_relative 'entry_registry'

module ProductCollection

  include EntryRegistry

  def product(entry, &block)
    @products ||= Array.new

    item = EntryRegistry.find_by_title entry
    if item.nil?
      raise 'List generation error: No product called ' + entry + ' has been defined'
    end
    @products.push ProductEntry.new item, &block
  end

  def products
    @products
  end

end
