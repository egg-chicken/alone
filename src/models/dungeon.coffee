Dealer = require('./dungeon/dealer')

module.exports = class DungeonGame
  constructor: ->
    @dealer = new Dealer()
    @dealer.setup()
