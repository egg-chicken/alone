Dealer = require('./models/dealer')
MainView = require('./views/main_view')
MainController = require('./controllers/main_controller')

module.exports = class Alone
  @start: ->
    console.log "start"
    dealer = new Dealer()
    mainView = new MainView(dealer)
    mainController = new MainController(mainView, dealer)
    mainView.render()

  @stop: ->
    console.log "stop"

  @reset: ->
    console.log "restart"
