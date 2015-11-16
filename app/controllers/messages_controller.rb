require 'rethinkdb'
require 'Tubesock'
include RethinkDB::Shortcuts

class MessagesController < ApplicationController
  include Tubesock::Hijack

  def websocket
    @connection = r.connect(:host => "localhost", :port => 28015).repl
    hijack do |tubesock|
      rethink_thread = Thread.new do
        r.table("messages").changes.run(@connection).each {|document| tubesock.send_data document["new_val"].to_json }
      end

      tubesock.onopen do
        p "onopen"
      end

      tubesock.onmessage do |message|
        p "onmessage"
        r.table("messages").insert({:message => "#{message}"}).run(@connection)
      end

      tubesock.onclose do
        p "onclose"
        rethink_thread.kill
      end
    end
  end
end
