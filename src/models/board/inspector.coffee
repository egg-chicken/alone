_ = require('underscore')

# 盤面を観察するためのクラス
# プレイヤーは、この情報をもとに戦術を組み立てる。
module.exports = class Inspector
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@board, @character)->
    @base = @character.getPosition()
    @hero = @board.getHero()

  findHero: ->
    if @board.isRoom(@base) && @board.isSameRoom(@base, @hero.getPosition())
      @hero
    else if @getDistance(@hero) < 2
      @hero
    else
      null

  findNearByDirection: (target)->
    targetPosition = target.getPosition?() || target
    method = (direction) => targetPosition.distance(@base[direction]())
    _.min(_.shuffle(DIRECTIONS), method)

  isNeighbor: (target)->
    @getDistance(target) < 2

  getNearestCharacterInSight: ->
    characters = @getCharactersInSight()
    return if _.isEmpty(characters)
    _.min(characters, (target) => @getDistance(target))

  getCharactersInSight: ->
    characters = @board.getCharacters()
    inRoom = @board.isRoom(@base)
    _.filter characters, (target) =>
      if target == @character
        false
      else if inRoom
        @board.isSameRoom(@base, target.getPosition())
      else
        @getDistance(target) == 1

  getDoorsInSight: ->
    if @board.isRoom(@base)
      @board.getDoors(@base)
    else
      []

  getDistance: (target)->
    target.getPosition().distance(@base)
