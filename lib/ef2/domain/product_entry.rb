require_relative 'collection_entry'

class ProductEntry < CollectionEntry
  def picker(picker=nil)
    picker.nil? ? @picker : @picker = picker
  end
end