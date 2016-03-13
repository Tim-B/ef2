module ASINCollection

  def asin(asin_code)
    @asins ||= Array.new
    @asins.push asin_code
  end

  def asins
    @asins
  end

  def pick picker
    picker.pick asins
  end

end
