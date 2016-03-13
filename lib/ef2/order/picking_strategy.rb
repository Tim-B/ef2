module EF2
  class PickingStrategy

    def initialize(default, *strategies)
      @strategies = Hash.new(default)
      @filters = Array.new

      strategies.each do |strategy|
        @strategies.store strategy.id, strategy
      end
    end

    def set_filters(*filters)
      @filters = filters
    end

    def pick(picker, product_entry, options, quantity)
      @filters.each do |filter|
        options = filter.filter product_entry, options
      end

      unless options.size > 0
        return Array.new
      end

      @strategies[picker].pick options, quantity
    end

  end
end