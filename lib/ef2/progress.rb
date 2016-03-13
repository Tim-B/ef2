require 'powerbar'

module EF2
  class Progress
    @bar = PowerBar.new
    @bar.settings.tty.finite.show_eta = false
    @progress = 0
    @order_size = 0
    @pick_size = 0
    @pick_offset = 0

    def self.set_pick_size size
      @pick_size = size * 5
    end

    def self.set_order_size size
      @pick_offset = (size / 5).round
      @order_size = size + @pick_offset
      @progress = @pick_offset
    end

    def self.put_order asin
      @progress += 1
      @bar.show(:msg => "Ordering #{asin}", :done => @progress, :total => @order_size)
    end

    def self.put_pick name
      @progress += 1
      @bar.show(:msg => "Picking #{name}", :done => @progress, :total => @pick_size)
    end

    def self.done
      @bar.show(:msg => 'Done!', :done => @order_size, :total => @order_size)
    end
  end
end
