module Entry

  module ClassMethods
    def title(title)
      @title = title
    end

    def description(description)
      @description = description
    end

    def categories(*categories)
      @categories = categories
    end

    def get_title
      @title
    end

    def get_description
      @description
    end

    def get_categories
      @categories
    end

  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def description
    self.class.get_description
  end

  def title
    self.class.get_title
  end

  def categories
    self.class.get_categories || []
  end

end
