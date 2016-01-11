_ = require('underscore')
Builder = require('./land/builder')
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
    table = new Array2D(width, height, 'a'.charCodeAt())
    for p in table.round()
      table.set(p, WALL)
    new Land(table)

  constructor: (@table)->

  getWidth: -> @table.width
  getHeight: -> @table.height

  getFreePositions: ->
    filtered = _.filter @table.pairs(), (p)=> @isRoom(p)
    _.shuffle(filtered)

  isWall: (position)->
    @table.get(position) == WALL

  isDoor: (position)->
    @table.get(position) == DOOR

  isExit: (position)->
    @table.get(position) == EXIT

  isRoom: (position)->
    @table.get(position) > EXIT

  isSameRoom: (a, b)->
    @table.get(a) == @table.get(b)

  getDoors: (position) ->
    roomCode = @table.get(position)
    _.filter @table.pairs(), (p) =>
      return false unless @isDoor(p)
      for direction in ['up', 'right', 'left', 'down']
        if @table.get(p[direction]()) == roomCode
          return true
      false

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
