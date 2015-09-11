_ = require('underscore')
Builder = require('./board/builder')
Array2D = require('utils/array2d')

module.exports = class Board
  WIDTH = 130
  HEIGHT = 30
  WALL = 0
  @HERO: 'H'
  constructor: ->
    @lands = Builder.create(WIDTH, HEIGHT)
    @characters = new Array2D(WIDTH, HEIGHT, null)
    free = _.find @lands.pairs(), (p)=> @lands.get(p) != WALL
    @characters.set(free, Board.HERO)

  get: (position) ->
    @characters.get(position)

  pop: (position) ->
    character = @characters.get(position)
    @characters.set(position, null)
    character

  put: (position, character) ->
    throw new Error("cannot put on the wall")  if @lands.get(position) == WALL
    throw new Error("character is already exist ") if @get(position)
    @characters.set(position, character)

  position: (character_id)->
    _.find @characters.pairs(), (p)=> @characters.get(p) == character_id

  to_s: ->
    display_table = new Array2D(WIDTH, HEIGHT)
    _.each @lands.pairs(), (p)=>
      symbol = @characters.get(p) || @lands.get(p)
      display_table.set(p, symbol)
    display_table.to_s()

  @test: ->
    board = new Board()
    console.log(board.to_s())
