require 'powerbar'

module EF2
  class Progress
    @bar = PowerBar.new
    @bar.settings.tty.finite.show_eta = false
    @progress = 0
    @order_size = 0

    def self.set_order_size size
      @order_size = size
    end

    def self.put_order asin
      @progress += 1
      @bar.show(:msg => "Ordering #{asin}", :done => @progress, :total => @order_size)
    end

    def self.done
      @bar.show(:msg => 'Done!', :done => @order_size, :total => @order_size)
    end
  end
end
