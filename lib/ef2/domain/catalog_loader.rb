require_relative 'entry_registry'
require_relative '../logger'

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
      EF2::Log.info "Loaded catalog item #{instance.title} from file #{file}"
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

end