_ = require("underscore")

module.exports = class Pair
  constructor: (@x, @y)->

  equal: (pair)->
    pair && pair.x == @x && pair.y == @y

  shift: (x, y)->
    new Pair(@x+x, @y+y)

  times: (k)->
    new Pair(@x*k, @y*k)

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

  where: (pair)->
    dir = null
    if @x == pair.x
      if @y > pair.y
        dir = "up"
      else if @y < pair.y
        dir = "down"
    else if @y == pair.y
      if @x > pair.x
        dir = "left"
      else if @x < pair.x
        dir = "right"
    dir

  to_s: ->
    "#{@x},#{@y}"
