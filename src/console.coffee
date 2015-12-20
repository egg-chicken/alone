Scenes  = require('./scenes/')

currentScene = new Scenes.Dungeon()
currentScene.play()
currentScene.on 'completed', ->
  currentScene.destruct()
  currentScene = new Scenes.Complete()
  currentScene.on 'completed', -> process.exit()
  currentScene.play()

currentScene.on 'failed',  ->
  currentScene.destruct()
  currentScene = new Scenes.GameOver()
  currentScene.on 'completed', -> process.exit()
  currentScene.play()
