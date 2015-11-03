_ = require('underscore')
Command = require('models/command')

module.exports = class Strategy
  SKILL_USE_RATE = 1/4
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@character)->
    @type = @character.getStrategy()

  createCommand: (inspector)->
    @inspector = inspector
    switch(@type)
      when 'whim'    then @whim()
      when 'guard'   then @guard()
      when 'devoted' then @devoted()
      else throw new Error('unknown strategy type #{@type}')

  whim: ->
    hero = @inspector.findHero()
    if hero && @inspector.isNeighbor(hero)
      @_attackOrUseSkill()
    else
      @_randomMove()

  guard: ->
    if @inspector.findHero()
      @_attackOrUseSkill()
    else
      @_randomMove()

  devoted: ->
    target = @inspector.getNearestCharacterInSight()
    if not target?
      @_randomMove()
    else if @inspector.getDistance(target) > 1
      @_approach(target)
    else if target == @inspector.findHero()
      @_attack(target)
    else
      @_useSkill(target)

  _attackOrUseSkill: (target)->
    if Math.random() > SKILL_USE_RATE
      @_attack()
    else
      @_useSkill(target)

  _approach: (target)->
    target ||= @inspector.findHero()
    direction = @inspector.findNearByDirection(target)
    Command.createMoveOrAttack(@character, direction)

  _attack: (target)-> @_approach(target)

  _useSkill: (target)->
    switch(@character.getSkillRange())
      when 1
        target ||= @inspector.findHero()
        Command.createUseSkill(@character, target)
      when 0
        Command.createUseSkill(@character, @character)
      else
        throw new Error('cannot deal the skill range: #{@character.getSkillRange()}')

  _randomMove: ->
    direction = _.sample(DIRECTIONS)
    Command.createMove(@character, direction)
