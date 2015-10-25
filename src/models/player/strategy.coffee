_ = require('underscore')
Command = require('models/command')

module.exports = class Strategy
  SKILL_USE_RATE = 1/4
  DIRECTIONS = ['up', 'down', 'left', 'right']
  @whim: (character, board)->
    strategy = new Strategy(character, board)
    strategy.whim()

  @guard: (character, board)->
    strategy = new Strategy(character, board)
    strategy.guard()

  @devoted: (character, board)->
    strategy = new Strategy(character, board)
    strategy.devoted()

  constructor: (@character, @board)->

  whim: ->
    if @board.isNeighbor()
      @_attackOrUseSkill()
    else
      @_randomMove()

  guard: ->
    if @board.isNeighbor() || @board.isSight()
      @_attackOrUseSkill()
    else
      @_randomMove()

  devoted: ->
    target = @board.getNearestCharacterInSight()
    if not target?
      @_randomMove()
    else if @board.getDistance(target) > 1
      @_approach(target)
    else if target == @board.getHero()
      @_attack(target)
    else
      @_useSkill(target)

  _attackOrUseSkill: (target)->
    if Math.random() > SKILL_USE_RATE
      @_attack()
    else
      @_useSkill(target)

  _approach: (target)->
    direction = @board.findNearByDirection(target)
    Command.createMoveOrAttack(@character, direction)

  _attack: (target)-> @_approach(target)

  _useSkill: (target)->
    target ||= @board.getHero()
    switch(@character.getSkillRange())
      when 1
        Command.createUseSkill(@character, target)
      when 0
        Command.createUseSkill(@character, @character)
      else
        throw new Error('cannot deal the skill range: #{@character.getSkillRange()}')

  _randomMove: ->
    direction = _.sample(DIRECTIONS)
    Command.createMove(@character, direction)
