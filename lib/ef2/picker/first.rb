module EF2
  module Picker
    class First

      def id
        :first
      end

      def pick options, quantity
        picked = Array.new

        quantity.times do
          picked.insert options.first
        end

        return picked
      end

    end
  end
end