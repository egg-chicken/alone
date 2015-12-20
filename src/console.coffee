Stage  = require('./stage')
stage = new Stage

onCompleted = ->
  stage.goto('Complete', -> process.exit())
onFailed    = ->
  stage.goto('GameOver', -> process.exit())

stage.goto('Dungeon', onCompleted, onFailed)
