Dealer = require('./models/dealer')
DungeonView = require('views/dungeon_view')
DungeonController = require('./controllers/dungeon_controller')

dealer     = new Dealer()
view       = new DungeonView(dealer)
view.activeAllListener()
controller = new DungeonController(dealer, view)
controller.onCompleteBoard = ->
  dealer.setupBoard()
  view.removeAllListeners()
  view = new DungeonView(dealer)
  view.activeAllListener()
  controller.constructor(dealer, view)
