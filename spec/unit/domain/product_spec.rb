require 'ef2/domain/collection_entry'

describe CollectionEntry do

  it 'gets and sets entry' do

    entry = double
    collection_entry = CollectionEntry.new entry

    expect(collection_entry.entry).to eq entry
  end

  it 'gets and sets quantity' do

    entry = double
    strategy = double
    allow(entry).to receive(:pick) { %w(a b c) }

    collection_entry = CollectionEntry.new entry do
      quantity 5
    end

    expect(entry).to receive(:pick).with(strategy, :first, collection_entry, 5)
    picked = collection_entry.pick strategy

    expect(picked).to eq %w(a b c)
    expect(collection_entry.quantity).to eq 5
  end

  it 'picks' do
    entry = double
    strategy = double
    allow(entry).to receive(:pick) { %w(a b c) }

    collection_entry = CollectionEntry.new entry

    expect(entry).to receive(:pick).with(strategy, :first, collection_entry, 1)
    picked = collection_entry.pick strategy

    expect(picked).to eq %w(a b c)
  end

end
