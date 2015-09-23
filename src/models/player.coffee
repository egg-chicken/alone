_ = require('underscore')

module.exports = class Player
  @MODE =
    HUMAN: 0
    COM: 1
  constructor: (@mode)->
    @hand = []
    @score = 0

  assign: (character)->
    if character instanceof Array
      @hand = @hand.concat(character)
    else
      @hand.push(character)

  characters: ->
    _.filter @hand, (character)-> not character.isDead()

  direction: (character)->
    _.sample ['up', 'down', 'left', 'right']

  getScore: ->
    @score

  addScore: (point)->
    @score += point

  getMode: ->
    @mode
