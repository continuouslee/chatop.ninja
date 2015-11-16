# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  socket = new WebSocket "ws://#{window.location.host}/chat"

  socket.onmessage = (event) ->
    if event.data.length
      data = JSON.parse(event.data)
      $("#chat-window").append "#{data.message}<br>"
      $("#chat-window").append "<strong>#{event.data}<strong><br>"

  $("body").on "submit", "form.chat", (event) ->
    event.preventDefault()
    $input = $(this).find("input")
    # alert($input.val)
    socket.send $input.val()
    $input.val(null)
