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
    @boardView.render()
    @playerView.render()
    @itemView.render()

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
            when 'i' then @emit('press:item-button')
            else @emit('press:next-button')
        when MODE.ITEMS
          switch(key.name)
            when 'i' then @emit('press:item-button')

  _isExitSignal: (key)->
    key.ctrl && key.name == 'c' || key.name == 'q'
