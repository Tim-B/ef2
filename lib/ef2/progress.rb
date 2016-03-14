require 'powerbar'

module EF2
  class Progress
    @bar = PowerBar.new
    @bar.settings.tty.finite.show_eta = false
    @disabled = true

    @stages = 0
    @stage = 0
    @progress = 0
    @size = 0

    def self.set_stages(stages)
      @stages = stages
      @stage = 0
      @progress = 0
      @size = 0
      @disabled = false
    end

    def self.start_stage(stage_size)
      @stage_size = stage_size
      @stage += 1
      @size = stage_size * @stages
      @progress = stage_size * (@stage - 1)
    end

    def self.stage_progress(message)
      @progress += 1

      unless @disabled
        @bar.show(:msg => message, :done => @progress, :total => @size)
      end

    end

    def self.done

      unless @disabled
        @bar.show(:msg => 'Done', :done => 100, :total => 100)
      end

    end
  end
end
