Dealer = require('./dungeon/dealer')
Player = require('./dungeon/player')

module.exports = class DungeonGame
  constructor: ->
    @dealer   = new Dealer()

  setupBoard: ->
    @dealer.setupBoard()
