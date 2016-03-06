require "ef2"

class BasicList < EF2::Domain::List

  recipe EF2::Catalog::Recipes::BaconAndEggs

  product EF2::Catalog::Products::ToiletPaper do
    quantity 5
    picker :random
  end

  order EF2::Order::Fresh.new

end
