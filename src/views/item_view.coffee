Console = require('utils/console')
EventEmitter = require('events').EventEmitter

module.exports = class ItemView extends EventEmitter
  constructor: (@items)->
    @focus = 0
    @visible = false

    keypress = require('keypress')
    keypress(process.stdin)
    @input = process.stdin
    @input.setRawMode(true)
    @input.on 'keypress', (ch, key)=>
      return unless @visible
      return unless key
      switch(key.name)
        when 'up'
          @focus = Math.max(0, @focus-1)
          @render()
        when 'down'
          @focus = Math.min(@items.length-1, @focus+1)
          @render()
        when 'return'
          if @items[@focus]
            @emit('press:use-item-button', @items[@focus])

  render: ->
    return unless @visible

    lines = []
    for i in [0...@items.length]
      item = @items[i]
      symbol = if i == @focus then '*' else ' '
      lines.push("#{symbol} #{item.getFullName()}: #{item.getDescription()}")
    Console.print(lines.join("\n"))

  hide: ->
    @visible = false

  show: ->
    @visible = true
