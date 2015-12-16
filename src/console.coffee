Dealer = require('./models/dealer')
DungeonSceneController = require('./controllers/dungeon_scene_controller')

dealer     = new Dealer()
controller = new DungeonSceneController(dealer)
