Scenes  = require('./scenes/')

currentScene = new Scenes.Dungeon()
currentScene.play()
currentScene.on 'completed', ->
  currentScene.destruct()
  currentScene = new Scenes.Dungeon()
  currentScene.play()
  # FIXME: 次の dungeon scene は終了イベントを登録してないので動かない

currentScene.on 'failed',  ->
  currentScene.destruct()
  currentScene = new Scenes.GameOver()
  currentScene.on 'completed', -> process.exit()
  currentScene.play()
