require 'yaml'

class FollowersStore

  def initialize
    @file = Application.db_root
  end
  
  def add(follower)
    @histories << follower if histories.last != follower
    save_to_file!
  end
  
  def histories
    @histories ||= load_from_file
  end
  
  def count
    histories.size
  end
  
  def to_array
    histories.map { |history| history.followers }
  end
  
  private
  
    def save_to_file!
      File.open(@file, "w") { |f| f.write(YAML.dump(to_array)) }
      reload_from_file
    end
  
    def load_from_file
      histories_from_db = []
      file = File.new(@file) rescue ""
      yaml = YAML.load(file)
    
      if yaml
        histories_from_db = yaml.map do |history|
          FollowersHistory.new(history)
        end
      end
      histories_from_db
    end
  
    def reload_from_file
      @histories = load_from_file
    end
  
end