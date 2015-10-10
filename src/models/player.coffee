_ = require('underscore')
Strategy = require('./player/strategy')

module.exports = class Player
  MODE =
    HUMAN: 0
    COMPUTER: 1
  constructor: (@mode)->
    @hand = []
    @score = 0
    @boardCount = 1

  @createHuman: -> new Player(MODE.HUMAN)
  @createComputer: -> new Player(MODE.COMPUTER)

  assign: (character)->
    if character instanceof Array
      @hand = @hand.concat(character)
    else
      @hand.push(character)

  characters: ->
    _.filter @hand, (character)-> not character.isDead()

  command: (character, board)->
    Strategy[character.getStrategy()](character, board)

  getScore: ->
    @score

  addScore: (point)->
    @score += point

  completeBoard: ->
    @score += @boardCount * 100
    @boardCount += 1
    @hand = []

  getBoardCount: ->
    @boardCount

  isHuman: ->
    @mode == MODE.HUMAN

  isComputer: ->
    @mode == MODE.COMPUTER
