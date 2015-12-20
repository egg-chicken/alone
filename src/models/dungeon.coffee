Dealer = require('./dungeon/dealer')

module.exports = class DungeonGame
  constructor: (difficulty = 1)->
    @dealer = new Dealer(difficulty)
    @dealer.setup()
