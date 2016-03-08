module Entry

  def title(title=nil)
    title.nil? ? @title : @title = title
  end

  def description(description=nil)
    description.nil? ? @description : @description = description
  end

  def categories(*categories)
    categories.empty? ? @categories : @categories = categories
  end

end
