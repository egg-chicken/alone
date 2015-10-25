_ = require('underscore')
Builder = require('./builder')
Array2D = require('utils/array2d')

module.exports = class Land
  WALL = 0
  DOOR = 1
  PATH = 2
  EXIT = 3
  @createRandom: (width, height)->
    land = new Land()
    land._randomize(width, height)
    land._setExit()
    land

  @createHall: (width, height) ->
    land = new Land()
    land.table = new Array2D(width, height, 'a'.charCodeAt())
    pairs = land.table.round()
    for p in pairs
      land.table.set(p, WALL)
    land

  getFreePositions: ->
    filtered = _.filter @table.pairs(), (p)=> @isRoom(p)
    _.shuffle(filtered)

  isWall: (position)->
    @table.get(position) == WALL

  isExit: (position)->
    @table.get(position) == EXIT

  isRoom: (position)->
    @table.get(position) > EXIT

  getTile: (position)->
    @table.get(position)

  getSymbol: (position)->
    switch(@table.get(position))
      when WALL then '#'
      when DOOR then '|'
      when PATH then ' '
      when EXIT then '@'
      else " "

  getSymbolDetail: (position)->
    tile = @table.get(position)
    switch(tile)
      when WALL then '#'
      when DOOR then '|'
      when EXIT then '@'
      else String.fromCharCode(tile)

  _setExit: ->
    pairs = _.shuffle(@table.pairs())
    position = _.find(pairs, (p)=> @isRoom(p))
    @table.set(position, EXIT)

  _randomize: (width, height)->
    @table = Builder.create(width, height)
    for p in @table.pairs()
      tile = @table.get(p)
      switch(tile)
        when 0
          @table.set(p, WALL)
        when '|'
          @table.set(p, DOOR)
        when '_'
          @table.set(p, PATH)
        else
          # ROOM
          @table.set(p, tile)
