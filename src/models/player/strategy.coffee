_ = require('underscore')
Command = require('models/command')

module.exports = class Strategy
  DIRECTIONS = ['up', 'down', 'left', 'right']
  @whim: (character, board)->
    if board.isNeighbor()
      direction = board.findNearByDirection()
      command = Command.createMoveOrAttack(direction)
    else if _.random(4) > 0
      direction = _.sample(DIRECTIONS)
      command = Command.createMove(direction)
    else
      command = Command.createUseSkill(character.getSkill(), character)
    command

  @guard: (character, board)->
    if board.isNeighbor() || board.isSight()
      direction = board.findNearByDirection()
      command = Command.createMoveOrAttack(direction)
    else
      @whim(character, board)

  @devoted: (character, board)->
    target = board.getNearestCharacterInSight()
    if target == board.getHero() || not(board.isNeighbor(target))
      direction = board.findNearByDirection(target)
      command = Command.createMoveOrAttack(direction)
    else if target
      command = Command.createUseSkill(character.getSkill(), target)
    else
      @whim(character, board)
