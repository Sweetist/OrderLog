require 'rubygems'
require 'csv'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.configurations = YAML::load(DATA)
ActiveRecord::Base.establish_connection('development')

class Record < ActiveRecord::Base
  self.table_name = "state" # <=== REPLACE THIS with your table name
end

CSV.foreach ARGV[0], :headers => true do |row|
  print "."
  hash = Hash[row]
  hash.delete("updated_at")
  hash.delete("created_at")
  Record.create! hash
end

puts "\nDone."

__END__
development:
  adapter: sqlite3
  database: db/development.sqlite3  # <=== REPLACE THIS with a relative path to your sqlite3 DB
  pool: 5
  timeout: 5000