require 'ef2/domain/list'
require_relative 'product_collection_spec'
require_relative 'recipe_collection_spec'

describe EF2::Domain::List do

  it_behaves_like 'a product collection'
  it_behaves_like 'a recipe collection'

end

