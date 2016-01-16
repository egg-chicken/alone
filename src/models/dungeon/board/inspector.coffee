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
    else if @character.distance(@hero) < 2
      @hero
    else
      null

  findNearByDirection: (target)->
    method = (direction) =>
      if @isWalkable(@base[direction]())
        target.distance(@base[direction]())
      else
        Infinity
    _.min(_.shuffle(DIRECTIONS), method)

  isWalkable: (target)->
    not(@board.isWall(target) || @board.get(target))

  getCharactersInSight: ->
    characters = @board.getCharacters()
    inRoom = @board.isRoom(@base)
    _.filter characters, (target) =>
      if target == @character
        false
      else if inRoom
        @board.isSameRoom(@base, target.getPosition())
      else
        @character.distance(target) == 1

  getDoorsInSight: ->
    if @board.isRoom(@base)
      @board.getDoors(@base)
    else
      []
