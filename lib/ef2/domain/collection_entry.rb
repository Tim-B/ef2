class CollectionEntry

  attr_reader :entry

  def initialize(entry, &block)
    @entry = entry
    @quantity = 1
    @picker = :random
    (block.arity < 1 ? (instance_eval &block) : block.call(self)) if block_given?
  end

  def entry(entry=nil)
    entry.nil? ? @entry : @entry = entry
  end

  def quantity(quantity=nil)
    quantity.nil? ? @quantity : @quantity = quantity
  end

  def picker(picker=nil)
    picker.nil? ? @picker : @picker = picker
  end

  def pick strategy
    entry.pick strategy, @picker, @quantity
  end
end