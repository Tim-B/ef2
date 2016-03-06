module ProductCollection

  module ClassMethods

    def product(entry, &block)
      @products ||= Array.new
      @products.push CollectionEntry.new entry.new, &block
    end

    def get_products
      @products
    end

  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def products
    self.class.get_products
  end

end
