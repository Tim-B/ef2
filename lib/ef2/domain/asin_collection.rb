module ASINCollection

  def asin(asin_code)
    @asins ||= Array.new
    @asins.push asin_code
  end

  def asins
    @asins ||= Array.new
  end

end
