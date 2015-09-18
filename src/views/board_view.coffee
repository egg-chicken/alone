Console = require('utils/console')
EventEmitter = require('events').EventEmitter

module.exports = class BoardView extends EventEmitter
  constructor: (@board)->
    @input = process.stdin
    @input.setEncoding('utf8')
    @input.on 'readable', ()=>
      data = process.stdin.read()
      switch(data)
        when "e\n" then @emit('press:exit-button')
        else            @emit('press:next-button', data)

  render: ->
    Console.print(@board)

  exit: ->
    Console.log('exit button pressed.')
