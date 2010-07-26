ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined?(ROOT)
DB_FILE = File.join(ROOT, 'db', 'data.yml')

require "#{ROOT}/lib/followers_store"
require "#{ROOT}/lib/followers_history"
