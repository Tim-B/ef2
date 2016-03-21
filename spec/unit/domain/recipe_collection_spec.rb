require 'ef2/domain/entry_registry'

shared_examples 'a recipe collection' do

  let(:recipe_collection) { described_class.new }

  it 'registers products and lists recipes' do

    recipe = double
    allow(recipe).to receive(:title) { 'some-recipe' }
    EntryRegistry.register recipe

    recipe_collection.recipe 'some-recipe' do
      quantity 5
    end

    expect(recipe_collection.recipes.size).to eq 1

    registered_recipe = recipe_collection.recipes.first
    expect(registered_recipe.entry).to eq recipe
    expect(registered_recipe.quantity).to eq 5
  end

  it 'rejects unknown recipes' do
    expect do
      recipe_collection.recipe 'foobar'
    end.to raise_error 'List generation error: No recipe foobar has been defined'
  end

end