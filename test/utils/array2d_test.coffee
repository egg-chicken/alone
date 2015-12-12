assert = require('assert')
Array2D = require('utils/array2d')
Pair = require('utils/pair')

describe 'Array2D', ->
  beforeEach ->
    @table = Array2D.create([
      [1,2,3,4,5]
      [5,1,2,3,4]
      [4,5,1,2,3]
    ])

  describe '#toString', ->
    it '２次元配列の中身を表現する文字列を返すこと', ->
      assert.equal(@table.toString(), "12345\n51234\n45123")

  describe '#get', ->
    it '指定した座標の値が取れること', ->
      assert.equal(@table.get(0,0), 1)
      assert.equal(@table.get(1,1), 1)
      assert.equal(@table.get(1,0), 2)
      assert.equal(@table.get(2,0), 3)
      assert.equal(@table.get(0,1), 5)
      assert.equal(@table.get(0,2), 4)

    it 'Pair型で指定した座標の値が取れること', ->
      assert.equal(@table.get(new Pair(0,2)), 4)

    it '領域外アクセスはエラーとなること', ->
      access = => @table.get(10,0)
      assert.throws(access, Array2D.OutOfBoundsError)

  describe '#set', ->
    it '指定した座標の値のみが変わること', ->
      @table.set(1, 2, 100)
      @table.each (x, y, value)->
        if x == 1 && y == 2
          assert.equal(value, 100)
        else
          assert(value < 100)

  describe '#rotate', ->
    it '時計回りに90度回転した２次元配列が得られること', ->
      rotated = @table.rotate()
      result = Array2D.create([
        [4,5,1]
        [5,1,2]
        [1,2,3]
        [2,3,4]
        [3,4,5]
      ])
      assert.equal(rotated.toString(), result.toString())

  describe '#round', ->
    before ->
      @table = Array2D.create([
        [0,0,0,0,0]
        [0,1,2,3,0]
        [0,0,0,0,0]
      ])

    it '周の配列が得られること', ->
      roundPairs = @table.round()
      for p in roundPairs
        assert.equal(@table.get(p), 0)
