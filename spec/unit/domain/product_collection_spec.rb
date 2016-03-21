require 'ef2/domain/entry_registry'
require_relative 'entry_registry_spec'

shared_examples 'a product collection' do

  let(:product_collection) { described_class.new }

  it 'registers products and lists them' do
    product = double
    allow(product).to receive(:title) { 'some-product' }
    EntryRegistry.register product

    product_collection.product 'some-product' do
      quantity 5
      picker :random
    end

    expect(product_collection.products.size).to eq 1
    registered_product = product_collection.products.first
    expect(registered_product.entry).to eq product
    expect(registered_product.quantity).to eq 5
    expect(registered_product.picker).to eq :random
  end

  it 'rejects unknown products' do
    expect do
      product_collection.product 'foobar' do
        quantity 5
        picker :random
      end
    end.to raise_error 'List generation error: No product called foobar has been defined'
  end

end