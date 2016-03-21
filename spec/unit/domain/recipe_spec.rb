require 'ef2/domain/recipe'
require 'ef2/domain/entry_registry'
require_relative 'entry_spec'
require_relative 'asin_collection_spec'
require_relative 'entry_registry_spec'

describe EF2::Domain::Recipe do

  it_behaves_like 'an entry'
  it_behaves_like 'a product collection'
  it_behaves_like 'a catalog loader'

  it 'picks products' do

    recipe = EF2::Domain::Recipe.new

    product1 = double
    allow(product1).to receive(:title) { 'some-product-1' }
    allow(product1).to receive(:pick) {['abc123']}
    EntryRegistry.register product1

    product2 = double
    allow(product2).to receive(:title) { 'some-product-2' }
    allow(product2).to receive(:pick) {['123abc']}
    EntryRegistry.register product2

    recipe.product 'some-product-1'
    recipe.product 'some-product-2'

    strategy = double

    items = recipe.pick strategy, :first, double, 3
    instances = items.each_with_object(Hash.new(0)) { |item,counts| counts[item] += 1 }

    expect(items.size).to eq 6
    expect(instances['abc123']).to eq 3
    expect(instances['123abc']).to eq 3

  end

end

