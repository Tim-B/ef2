require_relative 'entry_registry'

module RecipeCollection

  include EntryRegistry

  def recipe(entry, &block)
    @recipes ||= Array.new

    item = EntryRegistry.find_by_title entry
    @recipes.push CollectionEntry.new item, &block
  end

  def recipes
    @recipes
  end

end
