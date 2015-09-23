EventEmitter = require('events').EventEmitter
Console = require('utils/console')
ItemView = require('./item_view')

module.exports = class BoardView extends EventEmitter
  MODE = {
    BOARD: 0
    ITEMS: 1
  }
  constructor: (@board)->
    @mode = MODE.BOARD
    @itemView = new ItemView(@board.getHero().getItems())
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
          when 'i' then @emit('press:item-button')
          when 'e' then @emit('press:exit-button')
          else
            unless @mode == MODE.ITEMS
              @emit('press:next-button', key)

  render: ->
    switch(@mode)
      when MODE.BOARD
        lines = [@board.to_s()]
        lines.push(@board.getHero().toString()) if @board.getHero()
        Console.print(lines.join("\n"))
      when MODE.ITEMS
        @itemView.render()

  exit: ->
    Console.log('exit button pressed.')

  changeMode: ->
    @mode = (@mode + 1) % 2
    if @mode == MODE.ITEMS
      @itemView.show()
    else
      @itemView.hide()
