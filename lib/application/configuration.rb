module Application
  @@environment = 'development'
  
  class << self
    
    def root
      Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..', '..')))
    end
    
    def db_root
      Pathname.new(File.join(root, 'db', "#{env}.yml"))
    end
    
    def env
      @@environment
    end
    
    def env=(environment)
      @@environment = environment
    end
    
    [:test, :development, :production].each do |env|
      define_method "#{env}?" do
        @@environment == env.to_s
      end
    end
    
  end
end