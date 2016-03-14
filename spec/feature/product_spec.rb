require_relative '../spec_helper'
require_relative '../utils/list_harness'

describe 'A list with products' do
  it 'orders products' do

    order = ListHarness.run_list do

      product 'Basic Product 1'
      product 'Basic Product 2'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_2_Asin_1)
  end

  it 'supports quantity for product' do

    order = ListHarness.run_list do

      product 'Basic Product 1'
      product 'Basic Product 2' do
        quantity 2
      end

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_2_Asin_1 Basic_Product_2_Asin_1)
  end

  it 'supports multiple instances of the same product' do

    order = ListHarness.run_list do

      product 'Basic Product 1'
      product 'Basic Product 1'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_1_Asin_1)
  end

  it 'skips out of stock asins' do

    order = ListHarness.run_list :out_of_stock => ['Basic_Product_1_Asin_1'] do

      product 'Basic Product 1'
      product 'Basic Product 2'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_2 Basic_Product_2_Asin_1)
  end

  it 'skips out of stock asins with a random picker' do

    order = ListHarness.run_list :out_of_stock => ['Basic_Product_1_Asin_1'] do

      product 'Basic Product 1' do
        picker :random
      end
      product 'Basic Product 2'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_2 Basic_Product_2_Asin_1)
  end

  it 'picks products with random picker' do
    all_orders = Array.new

    20.times do
      order = ListHarness.run_list do

        product 'Basic Product 1' do
          picker :random
        end

      end
      all_orders.concat order
    end

    expect(all_orders).to include 'Basic_Product_1_Asin_1'
    expect(all_orders).to include 'Basic_Product_1_Asin_2'
  end

  it 'supports removing products with every' do

    order = ListHarness.run_list :last_ordered => {'Basic_Product_1_Asin_1' => 9} do

      product 'Basic Product 1' do
        every 10, :days
      end

      product 'Basic Product 2'

    end

    expect(order).to eq %w(Basic_Product_2_Asin_1)
  end

  it 'supports including products with every' do

    order = ListHarness.run_list :last_ordered => {'Basic_Product_1_Asin_1' => 11} do

      product 'Basic Product 1' do
        every 10, :days
      end

      product 'Basic Product 2'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_2_Asin_1)
  end

  it 'supports multiple every but ignores unqualified entries' do

    order = ListHarness.run_list :last_ordered => {'Basic_Product_1_Asin_1' => 11} do

      product 'Basic Product 1' do
        every 10, :days
      end

      product 'Basic Product 1' do
        every 12, :days
        quantity 2
      end

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1)
  end

  it 'should throw an exception if product isn\'t defined' do

    expect do
      ListHarness.run_list do
        product 'Not A Product'
      end
    end.to raise_error 'List generation error: No product called Not A Product has been defined'

  end
end
