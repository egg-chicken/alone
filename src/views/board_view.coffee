Console = require('utils/console')
EventEmitter = require('events').EventEmitter

module.exports = class BoardView extends EventEmitter
  constructor: (@board)->
    keypress = require('keypress')
    keypress(process.stdin)
    @input = process.stdin
    @input.setRawMode(true)
    @input.on 'keypress', (ch, key)=>
      return unless key
      if key.ctrl
        switch(key.name)
          when 'c' then  @emit('press:exit-button')
      else
        switch(key.name)
          when 'e' then @emit('press:exit-button')
          else          @emit('press:next-button', key)

  render: ->
    Console.print(@board)

  exit: ->
    Console.log('exit button pressed.')
