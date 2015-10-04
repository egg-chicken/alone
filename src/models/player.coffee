_ = require('underscore')
Command = require('./command')

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

  command: (character)->
    if _.random(4) > 0
      direction = _.sample(['up', 'down', 'left', 'right'])
      command = Command.createMoveOrAttack(direction)
    else
      command = Command.createUseSkill(character.getSkill())
    command

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
