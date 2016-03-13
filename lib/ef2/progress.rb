require 'powerbar'

module EF2
  class Progress
    @bar = PowerBar.new
    @bar.settings.tty.finite.show_eta = false

    def self.set_stages(stages)
      @stages = stages
      @stage = 0
      @progress = 0
      @size = 0
    end

    def self.start_stage(stage_size)
      @stage_size = stage_size
      @stage += 1
      @size = stage_size * @stages
      @progress = stage_size * (@stage - 1)
    end

    def self.stage_progress(message)
      @progress += 1
      @bar.show(:msg => message, :done => @progress, :total => @size)
    end

    def self.done
      @bar.show(:msg => 'Done', :done => 100, :total => 100)
    end
  end
end
