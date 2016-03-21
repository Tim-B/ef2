module EntryRegistry

  def self.register(me)
    @title_registry ||= Hash.new
    @title_registry[me.title] = me
  end

  def self.find_by_title(title)
    @title_registry[title]
  end

end