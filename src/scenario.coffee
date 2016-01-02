Storage = require('models/storage')
Stage  = require('./stage')

class Scenario
  play: ->
    onCompleted = ->
      if Storage.getDifficulty() < 5
        Stage.goto('Dungeon', onCompleted, onFailed)
      else
        Stage.goto('Complete', -> process.exit())

    onFailed    = ->
      Stage.goto('GameOver', -> process.exit())

    Stage.goto('Dungeon', onCompleted, onFailed)

module.exports = new Scenario()
