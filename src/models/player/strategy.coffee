_ = require('underscore')
Command = require('models/command')

module.exports = class Strategy
  SKILL_USE_RATE = 1/4
  DIRECTIONS = ['up', 'down', 'left', 'right']
  @whim: (character, inspector)->
    strategy = new Strategy(character, inspector)
    strategy.whim()

  @guard: (character, inspector)->
    strategy = new Strategy(character, inspector)
    strategy.guard()

  @devoted: (character, inspector)->
    strategy = new Strategy(character, inspector)
    strategy.devoted()

  constructor: (@character, @inspector)->

  whim: ->
    if @inspector.isNeighbor()
      @_attackOrUseSkill()
    else
      @_randomMove()

  guard: ->
    if @inspector.heroIsSight()
      @_attackOrUseSkill()
    else
      @_randomMove()

  devoted: ->
    target = @inspector.getNearestCharacterInSight()
    if not target?
      @_randomMove()
    else if @inspector.getDistance(target) > 1
      @_approach(target)
    else if target == @inspector.getHero()
      @_attack(target)
    else
      @_useSkill(target)

  _attackOrUseSkill: (target)->
    if Math.random() > SKILL_USE_RATE
      @_attack()
    else
      @_useSkill(target)

  _approach: (target)->
    direction = @inspector.findNearByDirection(target)
    Command.createMoveOrAttack(@character, direction)

  _attack: (target)-> @_approach(target)

  _useSkill: (target)->
    target ||= @inspector.getHero()
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
