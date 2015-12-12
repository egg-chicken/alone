Pair = require('./pair')

module.exports = class Array2D
  @create: (values) ->
    height = values.length
    width = values[0].length
    array2d = new Array2D(width, height)
    for y in [0...height]
      for x in [0...width]
        array2d.set(x, y, values[y][x])
    array2d

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

  each: (f)->
    for y in [0...@height]
      for x in [0...@width]
        f(x, y, @rows[y][x])
    @

  # ２次元配列を長方形とみなして、周の集合を返す
  round: ->
    a = []
    for y in [0...@height]
      for x in [0...@width]
        if(x == 0 || y == 0 || x == @width-1 || y == @height-1)
          a.push(new Pair(x, y))
    a

  # 時計回りに90度回転した Array2D を作成して返す
  rotate: ->
    a = new Array2D(@height, @width)
    for y in [0...@height]
      for x in [0...@width]
        a.set(@height-1-y, x, @get(x, y))
    a

  clear: (value=null)->
    for p in @pairs()
      a.set(p, value)

  to_s: ->
    @rows.join("\n").replace(/,/g, "")

  toString: ->
    @to_s()

  _check: (x, y) ->
    if x < 0 || y < 0 || y >= @height || x >= @width
      throw new Error("out of range #{x}, #{y}")
