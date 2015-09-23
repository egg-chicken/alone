_ = require('underscore')
Builder = require('./builder')

module.exports = class Land
  WALL = 0
  ROOM = 1
  PATH = 2
  EXIT = 3
  constructor: (width, height)->
    @table = Builder.create(width, height)
    _.each @table.pairs(), (p)=>
      switch(@table.get(p))
        when 0
          @table.set(p, WALL)
        when 1
          @table.set(p, ROOM)
        else
          @table.set(p, PATH)
    @table.set(@getFreePositions()[0], EXIT)

  getFreePositions: ->
    filtered = _.filter @table.pairs(), (p)=> @table.get(p) == ROOM
    _.shuffle(filtered)

  isWall: (position)->
    @table.get(position) == WALL

  isExit: (position)->
    @table.get(position) == EXIT

  getSymbol: (position)->
    switch(@table.get(position))
      when WALL then '#'
      when PATH then ' '
      when ROOM then ' '
      when EXIT then '@'
      else '?'
