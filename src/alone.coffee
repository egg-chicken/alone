Dealer = require('./models/dealer')
BoardView = require('./views/board_view')

module.exports = class Alone
  @start: ->
    console.log "start"
    dealer = new Dealer()
    boardView = new BoardView(dealer.board)

    turn = ->
      dealer.turn()
      boardView.render()
    setInterval(turn, 500)

  @stop: ->
    console.log "stop"

  @reset: ->
    console.log "restart"
