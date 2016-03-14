class CollectionEntry

  attr_reader :entry

  def initialize(entry, &block)
    @entry = entry
    @quantity = 1
    (block.arity < 1 ? (instance_eval &block) : block.call(self)) if block_given?
  end

  def quantity(quantity=nil)
    quantity.nil? ? @quantity : @quantity = quantity
  end

  def pick(strategy)
    @picker ||= :first
    entry.pick strategy, @picker, self, @quantity
  end
end