_ = require("underscore")

module.exports = class Pair
  constructor: (@x, @y)->

  equal: (pair)->
    pair.x == @x && pair.y == @y

  shift: (x, y)->
    new Pair(@x+x, @y+y)

  up: (y=1)->
    new Pair(@x, @y-y)

  down: (y=1)->
    new Pair(@x, @y+y)

  left: (x=1)->
    new Pair(@x-x, @y)

  right: (x=1)->
    new Pair(@x+x, @y)

  distance: (to)->
    Math.abs(@x - to.x) + Math.abs(@y - to.y)

  cover: (pair)->
    cov = []
    for x in [@x .. pair.x]
      for y in [@y .. pair.y]
        cov.push(new Pair(x, y))
    cov

  neighbors: ->
    _.shuffle([
      new Pair(@x, @y-1)
      new Pair(@x, @y+1)
      new Pair(@x-1, @y)
      new Pair(@x+1, @y)
    ])

  to_s: ->
    "#{@x},#{@y}"
