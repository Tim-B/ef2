shared_examples 'an entry' do

  let(:entry) { described_class.new }

  it 'sets and gets title' do
    entry.title 'foo'

    expect(entry.title).to eq 'foo'
  end

  it 'sets and gets description' do
    entry.description 'bar'

    expect(entry.description).to eq 'bar'
  end

  it 'sets and gets categories' do
    entry.categories :foo, :bar, :baz

    expect(entry.categories).to eq [:foo, :bar, :baz]
  end


end