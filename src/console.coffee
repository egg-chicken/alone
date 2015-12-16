Dealer = require('./models/dealer')
DungeonView = require('views/dungeon_view')
DungeonSceneController = require('./controllers/dungeon_scene_controller')

dealer     = new Dealer()
view       = new DungeonView(dealer)
controller = new DungeonSceneController(dealer, view)
controller.onCompleteBoard = ->
  dealer.setupBoard()
  view.removeAllListeners()
  view = new DungeonView(dealer)
  controller.constructor(dealer, view)
