require 'ef2/version'
require 'ef2/domain/list'
require 'ef2/domain/product'
require 'ef2/domain/recipe'

EF2::Domain::Product.load_dir File.dirname(__FILE__) + '/ef2/catalog/products'
EF2::Domain::Recipe.load_dir File.dirname(__FILE__) + '/ef2/catalog/recipes'