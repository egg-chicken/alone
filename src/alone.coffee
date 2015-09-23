Dealer = require('./models/dealer')
MainController = require('./controllers/main_controller')

module.exports = class Alone
  @start: ->
    console.log "start"
    dealer = new Dealer()
    mainController = new MainController(dealer)

  @stop: ->
    console.log "stop"

  @reset: ->
    console.log "restart"
