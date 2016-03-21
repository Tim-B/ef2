require 'ef2/domain/product'
require_relative 'entry_spec'
require_relative 'asin_collection_spec'
require_relative 'entry_registry_spec'

describe EF2::Domain::Product do

  it_behaves_like 'an entry'
  it_behaves_like 'an ASIN collection'
  it_behaves_like 'a catalog loader'

  it 'picks' do
    strategy = double
    allow(strategy).to receive(:pick) { %w(a b c) }
    entry = double

    expect(strategy).to receive(:pick).with(:first, entry,['abc123'],  5)

    product = EF2::Domain::Product.new
    product.asin 'abc123'
    picked = product.pick strategy, :first, entry, 5

    expect(picked).to eq %w(a b c)
  end

end

