Logger = require('./logger')

module.exports = class Command
  ACTIONS =
    MOVE_OR_ATTACK: 0
    USE_SKILL: 1
    USE_ITEM: 2
    MOVE: 3

  @createMove: (actor, direction)->
    command = new Command(ACTIONS.MOVE, actor)
    command.direction = direction
    command

  @createMoveOrAttack: (actor, direction) ->
    command = new Command(ACTIONS.MOVE_OR_ATTACK, actor)
    command.direction = direction
    command

  @createUseSkill: (actor, target)->
    command = new Command(ACTIONS.USE_SKILL, actor)
    command.target = target
    command

  @createUseItem: (actor, item)->
    command = new Command(ACTIONS.USE_ITEM, actor)
    command.item = item
    command

  constructor: (@action, @actor)->

  perform: (board)->
    switch(@action)
      when ACTIONS.USE_ITEM
        Logger.useItem(@actor, @item)
        @actor.useItem(@item)
      when ACTIONS.USE_SKILL
        Logger.useSkill(@actor, @actor.getSkill())
        try
          @_useSkill(board)
        catch e
          Logger.failed(e)
      when ACTIONS.MOVE_OR_ATTACK
        @_moveOrAttack(board)
      when ACTIONS.MOVE
        try
          @_move(board)
        catch e
          Logger.failed(e)

  _moveOrAttack: (board)->
    from = @actor.getPosition()
    to = from[@direction]()
    target = board.get(to)

    try
      if to && target
        @_attack(target, board)
      else if to
        @_move(board)
      else
        Logger.doNothing(@actor)
    catch e
      Logger.failed(e)

  _move: (board)->
    from = @actor.getPosition()
    to = from[@direction]()
    Logger.move(@actor, to)
    board.put(to, @actor)
    item = board.getItem(to)
    if item
      Logger.getItem(@actor, item)
      @actor.addItem(item)
      board.remove(item)

  _attack: (target, board)->
    Logger.attack(@actor, target)
    point = target.damage(1)
    Logger.isDamaged(target, point)

    if target.isDead()
      Logger.isDead(target)
      board.remove(target)

  _useSkill: (board)->
    switch(@actor.getSkill())
      when 'ACID'
        return # TODO: decrease the weapon duration on front character
      when 'GUARDFORM'
        @actor.addDiffenceBuffer(1, 2)
      when 'AID'
        if @target.isHealthy()
          throw new Error("He canceled skill, because that is meaningless")
        else if @actor.getSkillCount() <= 2
          @target.heal(3)
        else
          throw new Error("He doesn't have medicine!")
      when 'TACKLE'
        @_tackle(board)
      else
        throw new Error("use unknown skill #{name}")
    @actor.addSkillCount()

  _tackle: (board)->
    pa = @actor.getPosition()
    pt = @target.getPosition()
    if pa.distance(pt) > 1
      throw new Error('He cannot reach the target')

    for direction in ['up', 'down', 'left', 'right']
      testPosition = pa[direction]()
      if testPosition.equal(pt)
        backPosition = pt[direction]()
        if board.isWall(backPosition)
          @target.damage(1)
        else
          board.put(backPosition, @target)
