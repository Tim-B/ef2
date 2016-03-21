shared_examples 'an ASIN collection' do

  let(:entry) { described_class.new }

  it 'sets and gets ASINs' do
    entry.asin 'abc'
    entry.asin 'def'

    expect(entry.asins).to eq %w(abc def)
  end

  it 'returns empty ASINs' do
    expect(entry.asins).to eq []
  end

end