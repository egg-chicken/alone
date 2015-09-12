_ = require('underscore')
Array2D = require('utils/array2d')
Character = require('./character')
Land = require('./board/land')

module.exports = class Board
  WIDTH = 130
  HEIGHT = 30
  constructor: ->
    @land = new Land(WIDTH, HEIGHT)
    @characters = new Array2D(WIDTH, HEIGHT, null)
    @hero  = new Character(Character.HERO)
    @characters.set(@land.get_free_position(), @hero)

  get: (position) ->
    @characters.get(position)

  get_hero: ->
    @hero

  pop: (position) ->
    character = @characters.get(position)
    @characters.set(position, null)
    character

  put: (position, character) ->
    throw new Error("cannot put on the wall")  if @land.is_wall(position)
    throw new Error("character is already exist ") if @get(position)
    @characters.set(position, character)

  position: (character)->
    _.find @characters.pairs(), (p)=> @characters.get(p) == character

  to_s: ->
    display_table = new Array2D(WIDTH, HEIGHT)
    _.each display_table.pairs(), (p)=>
      symbol = @characters.get(p)?.get_symbol() || @land.get_symbol(p)
      display_table.set(p, symbol)
    display_table.to_s()

  @test: ->
    board = new Board()
    console.log(board.to_s())
