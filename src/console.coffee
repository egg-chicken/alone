Storage = require('models/storage')
Stage  = require('./stage')

onCompleted = ->
  if Storage.getDifficulty() < 5
    Stage.goto('Dungeon', onCompleted, onFailed)
  else
    Stage.goto('Complete', -> process.exit())

onFailed    = ->
  Stage.goto('GameOver', -> process.exit())

Stage.goto('Dungeon', onCompleted, onFailed)
