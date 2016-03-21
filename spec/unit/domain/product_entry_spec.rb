require 'ef2/domain/product_entry'

describe ProductEntry do

  let(:product) { double }

  it 'sets a picker' do

    product_entry = ProductEntry.new product do
      picker :foobar
    end

    expect(product_entry.picker).to eq :foobar
  end

  it 'sets every as days' do

    product_entry = ProductEntry.new product do
      every 5, :days
    end

    expect(product_entry.every_days).to eq 5
  end

  it 'sets every as weeks and converts it to days' do

    product_entry = ProductEntry.new product do
      every 2, :weeks
    end

    expect(product_entry.every_days).to eq 14
  end

  it 'rejects time units besides :weeks and :days' do
    expect do
      ProductEntry.new product do
        every 2, :months
      end
    end.to raise_error 'Time unit must be days or weeks'
  end

  it 'rejects every intervals longer than 90 days' do
    expect do
      ProductEntry.new product do
        every 91, :days
      end
    end.to raise_error 'The \'every\' time period must be less than 90 days.'
  end

  it 'should not rejects every intervals of 90 days' do

    product_entry = ProductEntry.new product do
      every 90, :days
    end

    expect(product_entry.every_days).to eq 90
  end

end
