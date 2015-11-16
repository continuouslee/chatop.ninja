require 'rethinkdb'
include RethinkDB::Shortcuts

connection = r.connect(:host => "localhost", :port => 28015).repl

r.db("test").table_create("messages").run

cursor = r.table("messages").changes.run
cursor.each {|document| p document }
