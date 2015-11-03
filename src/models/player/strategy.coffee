_ = require('underscore')
Command = require('models/command')

module.exports = class Strategy
  SKILL_USE_RATE = 1/4
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@character)->
    @type = @character.getStrategy()
    @milestone = null
    @prevPosition = null

  createCommand: (inspector)->
    @inspector = inspector
    switch(@type)
      when 'whim'     then @whim()
      when 'guard'    then @guard()
      when 'devoted'  then @devoted()
      when 'traveler' then @traveler()
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

  traveler: ->
    @milestone = null if @character.getPosition().equal(@milestone)
    hero = @inspector.findHero()
    doors = @inspector.getDoorsInSight()
    if hero
      @_attackOrUseSkill()
    else if @milestone?
      @_approach(@milestone)
    else if doors.length > 0
      @milestone = _.sample(doors)
      @_approach(@milestone)
    else
      for direction in DIRECTIONS
        next = @character.getPosition()[direction]()
        if !next.equal(@prevPosition) && @inspector.isWalkable(next)
          return @_approach(next)

  _attackOrUseSkill: (target)->
    if Math.random() > SKILL_USE_RATE
      @_attack()
    else
      @_useSkill(target)

  _approach: (target)->
    target ||= @inspector.findHero()
    direction = @inspector.findNearByDirection(target)
    @prevPosition = @character.getPosition()
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
