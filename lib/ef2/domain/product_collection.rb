require_relative 'collection_entry'
require_relative 'entry_registry'

module ProductCollection

  include EntryRegistry

  def product(entry, &block)
    @products ||= Array.new

    item = EntryRegistry.find_by_title entry
    @products.push CollectionEntry.new item, &block
  end

  def products
    @products
  end

end
