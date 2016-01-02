Storage = require('models/storage')
Stage = require('./stage')

class Scenario
  play: ->
    @stage = new Stage

    onCompleted = =>
      if Storage.getDifficulty() < 5
        @stage.goto('Dungeon', onCompleted, onFailed)
      else
        @stage.goto('Complete', -> process.exit())

    onFailed = =>
      @stage.goto('GameOver', -> process.exit())

    @stage.goto('Dungeon', onCompleted, onFailed)

module.exports = new Scenario()
