module SKUCollection

  module ClassMethods

    def sku(sku_code)
      @skus ||= Array.new
      @skus.push sku_code
    end

    def get_skus
      @skus
    end

  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def skus
    self.class.get_skus
  end

  def pick picker
    picker.pick skus
  end

end
