_ = require('underscore')

# 盤面を観察するためのクラス
# プレイヤーは、この情報をもとに戦術を組み立てる。
module.exports = class Inspector
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@board, @character)->
    @base = @character.getPosition()
    @hero = @board.getHero()

  getHero: ->
    @hero

  findNearByDirection: (target=@hero)->
    targetPosition = target.getPosition()
    method = (direction) =>
      targetPosition.distance(@base[direction]())
    _.min(_.shuffle(DIRECTIONS), method)

  isNeighbor: (target=@hero)->
    @getDistance(target) < 2

  isSight: ->
    return false unless @board.isRoom(@base)

    t1 = @board.getTile(@base)
    t2 = @board.getTile(@hero.getPosition())
    t1 == t2

  getNearestCharacterInSight: ->
    characters = @getCharactersInSight()
    return if _.isEmpty(characters)
    _.min(characters, (target) => @getDistance(target))

  getCharactersInSight: ->
    characters = @board.getCharacters()
    inRoom = @board.isRoom(@base)
    _.filter characters, (target) =>
      targetPosition = target.getPosition()
      if inRoom
        samePosition = targetPosition == @base
        sameRoom =  @board.getTile(@base) == @board.getTile(targetPosition)
        !samePosition && sameRoom
      else
        targetPosition.distance(@base) == 1

  getDoorsInSight: ->
    if @board.isRoom(@base)
      @board.getDoors(@base)
    else
      []

  getDistance: (target)->
    target.getPosition().distance(@base)
