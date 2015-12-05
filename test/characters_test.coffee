assert = require('assert')
Pair = require('utils/pair')
Characters = require('models/board/characters')

describe 'Characters', ->
  describe '#createOne', ->
    beforeEach ->
      @characters = new CharacterCollection()
      @freePositions = [new Pair(0, 0)]

    it 'monsterTable が無く、引数もない時エラーになること', ->
      createOne = => @characters.createOne(@freePositions)
      assert.throws(createOne, /unknown character:/)

    it 'monsterTable が有るとき、それに応じた敵が生成されること', ->
      @characters.monsterTable = [2]
      monster = @characters.createOne(@freePositions)
      assert(monster.type, 2)

    it '引数で指定したモンスターがいるとき、それに応じた敵が生成されること', ->
      @characters.monsterTable = [2]
      monster = @characters.createOne(@freePositions, 3)
      assert(monster.type, 3)
