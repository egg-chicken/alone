Dealer = require('./models/dealer')
BoardView = require('./views/board_view')
BoardController = require('./controllers/board_controller')

module.exports = class Alone
  @start: ->
    console.log "start"
    dealer = new Dealer()
    boardView = new BoardView(dealer.board)
    boardController = new BoardController(boardView, dealer)
    boardController.show()

  @stop: ->
    console.log "stop"

  @reset: ->
    console.log "restart"
