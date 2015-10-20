_    = require('underscore')
Pair = require('./pair')

module.exports = class Array2D
  constructor:(@width, @height, default_value=null) ->
    @rows = []
    for y in [0...@height]
      @rows[y] = []
      for x in [0...@width]
        @rows[y][x] = default_value

  set: (x, y, value)->
    if x instanceof Pair
      value = y
      y = x.y
      x = x.x
    @_check(x, y)
    @rows[y][x] = value

  get: (x, y)->
    if x instanceof Pair
      y = x.y
      x = x.x
    @_check(x, y)
    @rows[y][x]

  pairs: ->
    a = []
    for y in [0...@height]
      for x in [0...@width]
        a.push(new Pair(x, y))
    a

  # ２次元配列を長方形とみなして、周の集合を返す
  round: ->
    test = (p)=>(p.x == 0 || p.y == 0 || p.x == @width-1 || p.y == @height-1)
    _.filter(@pairs(), test)

  # 時計回りに90度回転した Array2D を作成して返す
  rotate: ->
    a = new Array2D(@height, @width)
    for p in @pairs()
      a.set(@height-1-p.y, p.x, @get(p))
    a

  clear: (value=null)->
    for p in @pairs()
      a.set(p, value)

  to_s: ->
    @rows.join("\n").replace(/,/g, "")

  _check: (x, y) ->
    if x < 0 || y < 0 || y >= @height || x >= @width
      throw new Error("out of range #{x}, #{y}")

  @test: ->
    table = new Array2D(5, 10, 0)
    table.set(0, 1, 8)
    table.set(new Pair(0, 2), 'A')
    console.log(table.to_s())
    console.log("--------------------")

    console.log(table.rotate().to_s())
    console.log("--------------------")

    try
      table.set(5, 10, 9)
    catch error
      console.log(error.name, error.message)
