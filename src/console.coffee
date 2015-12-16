DungeonScene = require('./scenes/dungeon_scene')
Dealer       = require('models/dealer')

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

currentScene = new DungeonScene(model)
currentScene.play()
currentScene.onFinished = (status)->
  if status == "success"
    nextScene()
