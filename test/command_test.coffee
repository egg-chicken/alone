assert = require('assert')
Command = require('models/command')
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
      before ->
        @board
        @character = Character.create('盲瓜坊')
        @target    = Character.createHero()
        @command   = Command.createUseSkill(@character, @target)

      it '対象が壁に挟まれている時一点のダメージを与える', ->
        @command._useSkill()
