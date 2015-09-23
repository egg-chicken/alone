console = require('better-console')
keypress = require('keypress')

ItemView = require('./item_view')
PlayerView = require('./player_view')
BoardView = require('./board_view')
EventEmitter = require('events').EventEmitter

# キーイベント、ビューの表示状態を一括管理するクラス
# 各ビューで個別イベントを分散管理しない理由は、
# 画面全体の描画タイミングを制御するのが困難なため。
module.exports = class MainView extends EventEmitter
  MODE =
    BOARD: 0
    ITEMS: 1

  constructor: (@dealer)->
    @playerView = new PlayerView(@dealer.players[0])
    @boardView = new BoardView(@dealer.board)
    @itemView = new ItemView(@dealer.board.getHero().getItems())
    @mode = MODE.BOARD
    @_initKeyEvents()

  render: ->
    console.clear()
    switch(@mode)
      when MODE.BOARD
        @boardView.render()
        @playerView.render()
      when MODE.ITEMS
        @itemView.render()
      else
        throw new Error("rendering with unknown view mode")

  exit: ->
    @input.removeAllListeners('keypress')

  _initKeyEvents: ->
    keypress(process.stdin)
    @input = process.stdin
    @input.setRawMode(true)
    @input.on 'keypress', (ch, key)=>
      return unless key
      return process.exit() if @_isExitSignal(key)
      switch(@mode)
        when MODE.BOARD
          switch(key.name)
            when 'i'
              @mode = MODE.ITEMS
              @render()
            when 'up', 'down', 'left', 'right'
              @emit('press:move-button', key)
            else
              @emit('press:skip-round-button')
        when MODE.ITEMS
          switch(key.name)
            when 'i'
              @mode = MODE.BOARD
              @render()
            when 'up', 'down'
              @itemView[key.name]()
              @render()
            when 'return'
              @mode = MODE.BOARD
              @emit('press:item-use-button', @itemView.getFocusedItem())

  _isExitSignal: (key)->
    key.ctrl && key.name == 'c' || key.name == 'q'
