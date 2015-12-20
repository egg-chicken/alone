Base = require('./base')

module.exports = class GameOverView extends Base
  render: ->
    @clear()
    @print("\n\n\n\n    GAME OVER\n\n\n\n")
