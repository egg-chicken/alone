keypress = require('keypress')

ItemView = require('./item')
PlayerView = require('./player')
BoardView = require('./board')
EventEmitter = require('events').EventEmitter

# キーイベント、ビューの表示状態を一括管理するクラス
# 各ビューで個別イベントを分散管理しない理由は、
# 画面全体の描画タイミングを制御するのが困難なため。
module.exports = class DungeonView extends EventEmitter
  MODE =
    BOARD: 0
    ITEMS: 1

  constructor: (@dealer)->
    @playerView = new PlayerView(@dealer.players[0])
    @boardView = new BoardView(@dealer.board)
    @itemView = new ItemView(@dealer.board.getHero().getItems())
    @mode = MODE.BOARD

  render: ->
    @_clearConsole()
    switch(@mode)
      when MODE.BOARD
        @boardView.render()
        @playerView.render()
      when MODE.ITEMS
        @itemView.render()
      else
        throw new Error("rendering with unknown view mode")

  activeAllListener: ->
    keypress(process.stdin)
    @input = process.stdin
    @input.setRawMode(true)
    @input.on 'keypress', (ch, key)=>
      return unless key
      return process.exit() if @_isExitSignal(key)
      switch(@mode)
        when MODE.BOARD then @_boardModeActions(key)
        when MODE.ITEMS then @_itemsModeActions(key)

  removeAllListeners: ->
    super
    @input.removeAllListeners('keypress')

  _clearConsole: ->
    termCode = '\u001B[2J\u001B[0;0f'
    process.stdout.write(termCode)

  _boardModeActions: (key)->
    if key.shift
      switch(key.name)
        when 'g'
          @emit('press:skill-button', 'GUARDFORM')
    else
      switch(key.name)
        when 'i'
          @mode = MODE.ITEMS
          @render()
        when 'up', 'down', 'left', 'right'
          @emit('press:move-button', key.name)
        else
          @emit('press:skip-round-button')

  _itemsModeActions: (key)->
    switch(key.name)
      when 'i'
        @mode = MODE.BOARD
        @render()
      when 'up', 'down'
        @itemView[key.name]()
        @render()
      when 'return'
        @mode = MODE.BOARD
        return unless @itemView.getFocusedItem()
        @emit('press:item-use-button', @itemView.getFocusedItem())

  _isExitSignal: (key)->
    key.ctrl && key.name == 'c' || key.name == 'q'
