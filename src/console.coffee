Scenes  = require('./scenes/')
Dealer = require('models/dealer')

currentScene = null
model = new Dealer()

currentScene = new Scenes.Dungeon(model)
currentScene.play()
currentScene.on 'completed', ->
  currentScene.destruct()
  model.setupBoard()
  currentScene = new Scenes.Dungeon(model)
  currentScene.play()
  # FIXME: 次の dungeon scene は終了イベントを登録してないので動かない

currentScene.on 'failed',  ->
  currentScene.destruct()
  currentScene = new Scenes.GameOver()
  currentScene.on 'completed', -> process.exit()
  currentScene.play()
