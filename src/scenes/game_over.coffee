Base         = require('./base')
GameOverView = require('views/game_over_view.coffee')
module.exports = class GameOverScene extends Base
  constructor: ->
    @view = new GameOverView()

  play: ->
    @view.render()
    @emit('completed')

  destruct: ->
    @view = null
    super
