shared_examples 'a catalog loader' do

  it 'loads a directory containing catalog items' do
    product_dir = '../../fixtures/catalog/products'
    described_class.load_dir product_dir

    loaded_product_1 = EntryRegistry.find_by_title 'Basic Product 1'
    expect(loaded_product_1.title).to eq 'Basic Product 1'

    loaded_product_2 = EntryRegistry.find_by_title 'Basic Product 2'
    expect(loaded_product_2.title).to eq 'Basic Product 2'
  end

end