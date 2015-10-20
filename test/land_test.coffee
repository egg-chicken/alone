assert = require('assert')
Land = require('models/board/land')
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
          assert.equal(@land.getTile(p), roomCode)
