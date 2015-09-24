_ = require('underscore')

module.exports = class Player
  @MODE =
    HUMAN: 0
    COM: 1
  constructor: (@mode)->
    @hand = []
    @score = 0
    @boardCount = 1

  assign: (character)->
    if character instanceof Array
      @hand = @hand.concat(character)
    else
      @hand.push(character)

  characters: ->
    _.filter @hand, (character)-> not character.isDead()

  direction: (character)->
    {
      command: _.sample ['up', 'down', 'left', 'right', 'useSkill']
      arg: character.getSkill()
    }

  getScore: ->
    @score

  addScore: (point)->
    @score += point

  completeBoard: ->
    @score += @boardCount * 100
    @boardCount += 1
    @hand = []

  getMode: ->
    @mode

  getBoardCount: ->
    @boardCount
