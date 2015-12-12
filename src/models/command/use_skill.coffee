Command = require('./command')

module.exports = class UseSkill extends Command
  constructor: (@actor, @target)->

  perform: (board)->
    try
      @_useSkill(board)
    catch e
      @failed = e

  _useSkill: (board)->
    @skill = @actor.getSkill()
    switch(@skill)
      when 'ACID'
        return # TODO: decrease the weapon duration on front character
      when 'GUARDFORM'
        @actor.addDiffenceBuffer(1, 2)
      when 'AID'
        @_aid()
      when 'TACKLE'
        @_tackle(board)
      else
        throw new Error("use unknown skill #{name}")
    @actor.addSkillCount()

  _aid: ()->
    if @target.isHealthy()
      throw new Error("He canceled skill, because that is meaningless")
    else if @actor.getSkillCount() > 2
      throw new Error("He doesn't have medicine!")
    else
      @target.heal(3)

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
