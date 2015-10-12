Logger = require('./logger')

module.exports = class Command
  ACTIONS =
    MOVE_OR_ATTACK: 0
    USE_SKILL: 1
    USE_ITEM: 2
    MOVE: 3

  @createMove: (direction)->
    command = new Command(ACTIONS.MOVE)
    command.direction = direction
    command

  @createMoveOrAttack: (direction) ->
    command = new Command(ACTIONS.MOVE_OR_ATTACK)
    command.direction = direction
    command

  @createUseSkill: (skill, target)->
    command = new Command(ACTIONS.USE_SKILL)
    command.skill = skill
    command.target = target
    command

  @createUseItem: (item)->
    command = new Command(ACTIONS.USE_ITEM)
    command.item = item
    command

  constructor: (@action)->
    @score = 0

  perform: (character, board)->
    switch(@action)
      when ACTIONS.USE_ITEM
        Logger.useItem(character, @item)
        character.useItem(@item)
      when ACTIONS.USE_SKILL
        Logger.useSkill(character, @skill)
        try
          character.useSkill(@skill, @target)
        catch e
          Logger.failed(e)
      when ACTIONS.MOVE_OR_ATTACK
        @_moveOrAttack(character, board)
      when ACTIONS.MOVE
        try
          @_move(character, board)
        catch e
          Logger.failed(e)

  getScore: ->
    @score

  _moveOrAttack: (character, board)->
    from = character.getPosition()
    to = from[@direction]()
    target = board.get(to)

    try
      if to && target
        @_attack(character, target, board)
      else if to
        @_move(character, board)
      else
        Logger.doNothing(character)
    catch e
      Logger.failed(e)

  _move: (character, board)->
    from = character.getPosition()
    to = from[@direction]()
    Logger.move(character, to)
    board.put(to, character)
    item = board.getItem(to)
    if item
      Logger.getItem(character, item)
      character.addItem(item)
      board.remove(item)

  _attack: (character, target, board)->
    Logger.attack(character, target)
    point = target.damage(1)
    Logger.isDamaged(target, point)

    if target.isDead()
      Logger.isDead(target)
      board.remove(target)
      @score += target.getScore()
