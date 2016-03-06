module RecipeCollection

  module ClassMethods

    def recipe(entry, &block)
      @recipes ||= Array.new
      @recipes.push CollectionEntry.new entry.new, &block
    end

    def get_recipes
      @recipes
    end

  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def recipes
    self.class.get_recipes
  end

end
