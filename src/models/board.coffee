_ = require('underscore')
Array2D = require('utils/array2d')
Characters = require('./board/characters')
Land = require('./board/land')

module.exports = class Board
  WIDTH = 130
  HEIGHT = 30
  INITIAL_ENEMY_COUNT = 5
  constructor: ->
    @land = new Land(WIDTH, HEIGHT)
    @characters = new Characters(WIDTH, HEIGHT)
    @characters.generate_hero(@land.get_free_positions())
    @characters.generate_enemies(@land.get_free_positions(), INITIAL_ENEMY_COUNT)

  get_hero:       -> @characters.get_hero()
  get: (position) -> @characters.get(position)
  pop: (position) -> @characters.pop(position)
  position: (character)-> @characters.position(character)
  put: (position, character) ->
    throw new Error("cannot put on the wall")  if @land.is_wall(position)
    throw new Error("character is already exist ") if @get(position)
    @characters.set(position, character)

  to_s: ->
    display_table = new Array2D(WIDTH, HEIGHT)
    _.each display_table.pairs(), (p)=>
      symbol = @characters.get_symbol(p) || @land.get_symbol(p)
      display_table.set(p, symbol)
    display_table.to_s()

  @test: ->
    board = new Board()
    console.log(board.to_s())
