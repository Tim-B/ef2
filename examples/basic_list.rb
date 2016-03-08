
recipe 'Bacon and Eggs'

product 'Toilet Paper' do
  quantity 5
  picker :random
end

product 'Ketchup' do
  picker :first
  every 6, :weeks
end

order EF2::Order::Fresh.new
