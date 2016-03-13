module EF2
  class PickingStrategy

    def initialize default, *strategies
      @strategies = Hash.new(default)
      @filters = Array.new

      strategies.each do |strategy|
        @strategies.store strategy.id, strategy
      end
    end

    def set_filters *filters
      @filters = filters
    end

    def pick picker, options, quantity
      @filters.each do |filter|
        options = filter.filter options
      end

      picked = @strategies[picker].pick options, quantity
      picked
    end

  end
end