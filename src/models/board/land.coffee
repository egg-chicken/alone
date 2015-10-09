_ = require('underscore')
Builder = require('./builder')

module.exports = class Land
  WALL = 0
  PATH = 2
  EXIT = 3
  constructor: (width, height)->
    @table = Builder.create(width, height)
    _.each @table.pairs(), (p)=>
      tile = @table.get(p)
      switch(tile)
        when 0
          @table.set(p, WALL)
        when '_'
          @table.set(p, PATH)
        else
          # ROOM
          @table.set(p, tile)

    @table.set(@getFreePositions()[0], EXIT)

  getFreePositions: ->
    filtered = _.filter @table.pairs(), (p)=> @isRoom(p)
    _.shuffle(filtered)

  isWall: (position)->
    @table.get(position) == WALL

  isExit: (position)->
    @table.get(position) == EXIT

  isRoom: (position)->
    @table.get(position) > EXIT

  getSymbol: (position)->
    switch(@table.get(position))
      when WALL then '#'
      when PATH then ' '
      when EXIT then '@'
      else " "

  getSymbolDetail: (position)->
    tile = @table.get(position)
    switch(tile)
      when WALL then '#'
      when PATH then ' '
      when EXIT then '@'
      else String.fromCharCode(tile)
