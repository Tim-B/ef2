shared_examples 'an entry registry' do

  it 'registers and find_by_title' do
    entry = double
    allow(entry).to receive(:title) { 'something' }

    described_class.register entry
    expect(described_class.find_by_title 'something').to eq entry
  end

end