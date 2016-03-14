require_relative '../spec_helper'
require_relative '../utils/list_harness'

describe EF2 do
  it 'orders a recipe' do

    order = ListHarness.run_list do

      recipe 'Basic Recipe 1'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_2_Asin_1)
  end

  it 'supports recipes mixed with products' do

    order = ListHarness.run_list do

      recipe 'Basic Recipe 1'

      product 'Basic Product 2'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_2_Asin_1 Basic_Product_2_Asin_1)
  end

  it 'supports multiple recipes' do

    order = ListHarness.run_list do

      recipe 'Basic Recipe 1'
      recipe 'Basic Recipe 1'

    end

    expect(order).to eq %w(Basic_Product_1_Asin_1 Basic_Product_2_Asin_1 Basic_Product_1_Asin_1 Basic_Product_2_Asin_1)
  end

  it 'supports recipes with multiple products' do

    order = ListHarness.run_list do

      recipe 'Basic Recipe 2'

    end

    expect(order).to eq %w(Basic_Product_2_Asin_1 Basic_Product_2_Asin_1 Basic_Product_2_Asin_1)
  end

end
