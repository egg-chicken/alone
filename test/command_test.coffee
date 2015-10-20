assert = require('assert')
Pair = require('utils/pair')
Command = require('models/command')
Board = require('models/board')
Character = require('models/board/character')

describe 'Command', ->
  describe '#useSkill', ->
    describe '手当', ->
      beforeEach ->
        @character = Character.create('葛籠鼠')
        @target    = Character.create('盲瓜坊')
        @command = Command.createUseSkill(@character, @target)

      it '体力が減っていない時失敗する', ->
        aid = => @command._useSkill()
        assert.throws(aid, Error, 'He canceled skill, because that is meaningless')

      it '体力が減っている時成功し、対象を回復する', ->
        @target.damage(2)
        @command._useSkill()
        assert(@target.isHealthy())

      it '3回成功した後、それ以降常に失敗する', ->
        aid = =>
          @target.damage(2)
          @command._useSkill()
        for i in [0...3]
          aid()
        for i in [0...2]
          assert.throws(aid, Error, "He doesn't have medicine!")

    describe '突進', ->
      beforeEach ->
        @board = Board.createHall(10, 10)
        @character = @board.createOne('盲瓜坊')
        @target = @board.createOne('主人公')
        @command = Command.createUseSkill(@character, @target)

      it '対象が距離2以上の時失敗する', ->
        tackle = => @command._useSkill(@board)
        @board.put(new Pair(1, 1), @character)
        @board.put(new Pair(2, 2), @target)
        assert.throws(tackle, Error, 'He cannot reach the target')

      it '対象が壁に挟まれている時ダメージを与える', ->
        @board.put(new Pair(1, 1), @target)
        @board.put(new Pair(1, 2), @character)
        @command._useSkill(@board)
        assert(not @target.isHealthy())

      it '対象が壁に挟まれていない時、ダメージを与えず、強制的に移動させる', ->
        @board.put(new Pair(1, 2), @target)
        @board.put(new Pair(1, 3), @character)
        @command._useSkill(@board)
        assert(@target.isHealthy())
        assert.equal(@board.get(new Pair(1,1)), @target)
