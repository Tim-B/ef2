module SKUCollection

  def sku(sku_code)
    @skus ||= Array.new
    @skus.push sku_code
  end

  def skus
    @skus
  end

  def pick picker
    picker.pick skus
  end

end
