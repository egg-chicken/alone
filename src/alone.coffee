Dealer = require('./models/dealer')
Console = require('utils/console')

module.exports = class Alone
  @start: ->
    console.log "start"
    dealer = new Dealer()
    turn = ->
      dealer.turn()
      Console.print(dealer.board)
    setInterval(turn, 500)

  @stop: ->
    console.log "stop"

  @reset: ->
    console.log "restart"
