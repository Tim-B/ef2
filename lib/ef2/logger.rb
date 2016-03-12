require 'logger'

module EF2
  class Log

    @logger = Logger.new(STDOUT)
    @logger.level = Logger::UNKNOWN

    def self.verbose
      @logger.level = Logger::INFO
    end

    def self.info message
      @logger.info message
    end

    def self.debug message
      @logger.debug message
    end

    def self.warn message
      @logger.warn message
    end

    def self.error message
      @logger.error message
    end

    def self.fatal message
      @logger.fatal message
    end

  end
end