require_relative 'entry_registry'

module RecipeCollection

  def recipe(entry, &block)
    @recipes ||= Array.new

    item = EntryRegistry.find_by_title entry

    if item.nil?
      raise "List generation error: No recipe #{entry} has been defined"
    end

    @recipes.push CollectionEntry.new item, &block
  end

  def recipes
    @recipes || Array.new
  end

end
