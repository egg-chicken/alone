_ = require('underscore')

# 盤面を観察するためのクラス
# プレイヤーは、この情報をもとに戦術を組み立てる。
module.exports = class Inspector
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@board, @character)->
    @hero = @board.getHero()

  getHero: ->
    @hero

  findNearByDirection: (target=@hero)->
    position = @character.getPosition()
    targetPosition = target.getPosition()
    method = (direction) ->
      targetPosition.distance(position[direction]())
    _.min(_.shuffle(DIRECTIONS), method)

  isNeighbor: (target=@hero)->
    @getDistance(target) < 2

  isSight: ->
    return false unless @board.isRoom(@character.getPosition())

    t1 = @board.getTile(@character.getPosition())
    t2 = @board.getTile(@hero.getPosition())
    t1 == t2

  getNearestCharacterInSight: ->
    characters = @getCharactersInSight()
    return if _.isEmpty(characters)
    _.min(characters, (target) => @getDistance(target))

  getCharactersInSight: ->
    characters = @board.getCharacters()
    position = @character.getPosition()
    inRoom = @board.isRoom(position)
    _.filter characters, (target) =>
      targetPosition = target.getPosition()
      if inRoom
        samePosition = targetPosition == position
        sameRoom =  @board.getTile(position) == @board.getTile(targetPosition)
        !samePosition && sameRoom
      else
        targetPosition.distance(position) == 1

  getDoorsInSight: ->
    position = @character.getPosition()
    if @board.isRoom(position)
      @board.getDoors(position)
    else
      []

  getDistance: (target)->
    target.getPosition().distance(@character.getPosition())
