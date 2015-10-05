_ = require('underscore')
Command = require('models/command')

module.exports = class Strategy
  @whim: (character)->
    if _.random(4) > 0
      direction = _.sample(['up', 'down', 'left', 'right'])
      command = Command.createMoveOrAttack(direction)
    else
      command = Command.createUseSkill(character.getSkill())
    command

  @aggressive: (character, board)->
