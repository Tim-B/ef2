module EF2
  module Pickers
    module Fresh
      class First

        def id
          :first
        end

        def pick options, quantity
          picked = Array.new

          quantity.times do
            picked.push options.first
          end

          return picked
        end

      end
    end
  end
end