assert = require('assert')
Pair = require('utils/pair')

describe 'Pair', ->
  beforeEach ->
    @pair = new Pair(1, 2)

  describe '#toString', ->
    it 'xy座標を表現する文字列を返すこと', ->
      assert.equal(@pair.toString(), "1,2")

  describe '#equal', ->
    it '同じ値を持つオブジェクトが等価となること', ->
      assert(@pair.equal(new Pair(1, 2)))

  describe '#shift', ->
    it 'xy座標に平行移動したオブジェクトを返すこと', ->
      shifted = @pair.shift(10, 20)
      assert.equal(shifted.x, 11)
      assert.equal(shifted.y, 22)

  describe '#up', ->
    it '無引数のとき上に距離１移動したオブジェクトを返すこと', ->
      moved = @pair.up()
      assert.equal(moved.x, 1)
      assert.equal(moved.y, 1)
    it '引数有りのとき上に距離N移動したオブジェクトを返すこと', ->
      moved = @pair.up(10)
      assert.equal(moved.x, 1)
      assert.equal(moved.y, -8)

  describe '#down', ->
    it '無引数のとき下に距離１移動したオブジェクトを返すこと', ->
      moved = @pair.down()
      assert.equal(moved.x, 1)
      assert.equal(moved.y, 3)
    it '引数有りのとき下に距離N移動したオブジェクトを返すこと', ->
      moved = @pair.down(10)
      assert.equal(moved.x, 1)
      assert.equal(moved.y, 12)

  describe '#left', ->
    it '無引数のとき左に距離１移動したオブジェクトを返すこと', ->
      moved = @pair.left()
      assert.equal(moved.x, 0)
      assert.equal(moved.y, 2)
    it '引数有りのとき左に距離N移動したオブジェクトを返すこと', ->
      moved = @pair.left(10)
      assert.equal(moved.x, -9)
      assert.equal(moved.y, 2)

  describe '#right', ->
    it '無引数のとき右に距離１移動したオブジェクトを返すこと', ->
      moved = @pair.right()
      assert.equal(moved.x, 2)
      assert.equal(moved.y, 2)
    it '引数有りのとき右に距離N移動したオブジェクトを返すこと', ->
      moved = @pair.right(10)
      assert.equal(moved.x, 11)
      assert.equal(moved.y, 2)

  describe '#distance', ->
    it '同じ点の時、０を返すこと', ->
      assert.equal(@pair.distance(new Pair(1, 2)), 0)
    it '離れた点の時、斜めを使わない最短距離を返すこと', ->
      assert.equal(@pair.distance(new Pair(3, 5)),   5)
      assert.equal(@pair.distance(new Pair(-1, -5)), 9)

  describe '#where', ->
    it '同じ点の時、null を返すこと', ->
      assert.equal(@pair.where(new Pair(1, 2)), null)
    it '引数で与えられた点が上にあるとき up を返すこと', ->
      assert.equal(@pair.where(new Pair(1, -1)), 'up')
    it '引数で与えられた点が下にあるとき down を返すこと', ->
      assert.equal(@pair.where(new Pair(1, 10)), 'down')
    it '引数で与えられた点が左にあるとき left を返すこと', ->
      assert.equal(@pair.where(new Pair(-1, 2)), 'left')
    it '引数で与えられた点が右にあるとき right を返すこと', ->
      assert.equal(@pair.where(new Pair(10, 2)), 'right')
