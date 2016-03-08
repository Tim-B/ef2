module EF2
  module Pickers
    module Fresh
      class Random

        def id
          :random
        end

        def pick options, quantity
          picked = Array.new

          quantity.times do
            picked.push options.sample
          end

          picked
        end

      end
    end
  end
end