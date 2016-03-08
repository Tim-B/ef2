require_relative 'entry_registry'

module CatalogLoader

  include EntryRegistry

  module ClassMethods
    def load_dir dir
      Dir[dir + '/*'].each do |file|
        load_file file
      end
    end

    def load_file file
      instance = new
      instance.instance_eval(File.read(file))
      EntryRegistry.register instance
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

end