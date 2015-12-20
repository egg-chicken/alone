assert = require('assert')
Land = require('models/dungeon/board/land')
Pair = require('utils/pair')
Array2D = require('utils/array2d')

describe 'Land', ->
  describe '#createHall', ->
    before ->
      @land = Land.createHall(10, 20)

    it '長方形の周が壁であること', ->
      pairs = new Array2D(10, 20).round()
      for p in pairs
        assert(@land.isWall(p))

    it '長方形の内部が単一の部屋であること', ->
      pairs = new Array2D(10, 20).pairs()
      roomCode = 'a'.charCodeAt()
      for p in pairs
        unless p.x == 0 || p.y == 0 || p.x == 9 || p.y == 19
          assert.equal(@land.table.get(p), roomCode)

  describe '#getDoors', ->
    before ->
      @land = new Land()
      @land.table = Array2D.create([
        [0,0,0,0,0,0,0,0,0,0]
        [0,9,9,0,0,0,8,8,8,0]
        [0,9,9,0,2,1,8,8,8,0]
        [0,9,9,1,2,0,8,8,8,0]
        [0,0,0,0,0,0,0,0,0,0]
      ])

    it '右にあるドアが見つかること', ->
      doors = @land.getDoors(new Pair(1, 2))
      assert.equal(doors.length, 1)
      assert.equal(doors[0].x, 3)
      assert.equal(doors[0].y, 3)

    it '左にあるドアが見つかること', ->
      doors = @land.getDoors(new Pair(8, 2))
      assert.equal(doors.length, 1)
      assert.equal(doors[0].x, 5)
      assert.equal(doors[0].y, 2)
