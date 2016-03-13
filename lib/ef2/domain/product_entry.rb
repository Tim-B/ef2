require_relative 'collection_entry'

class ProductEntry < CollectionEntry

  attr_reader :every_days

  def picker(picker=nil)
    picker.nil? ? @picker : @picker = picker
  end

  def every(value, time_unit)
    unless [:days, :weeks].include? time_unit
      raise 'Time unit must be days or weeks'
    end

    multi = 1
    if time_unit == :weeks
      multi = 7
    end

    if value * multi > 90
      raise 'The \'every\' time period must be less than 90 days.'
    end

    @every_days = value * multi
  end
end