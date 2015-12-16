DungeonScene  = require('./scenes/dungeon_scene')
GameOverScene = require('./scenes/game_over_scene')
Dealer        = require('models/dealer')

currentScene = null
model = new Dealer()

nextScene = ->
  currentScene.destruct()
  model.setupBoard()

  currentScene = new DungeonScene(model)
  currentScene.play()
  currentScene.onFinished = (status)->
    if status == "success"
      nextScene()
    else
      currentScene = new GameOverScene()
      currentScene.onFinished = -> process.exit()
      currentScene.play()


currentScene = new DungeonScene(model)
currentScene.play()
currentScene.onFinished = (status)->
  if status == "success"
    nextScene()
  else
    currentScene = new GameOverScene()
    currentScene.onFinished = -> process.exit()
    currentScene.play()
