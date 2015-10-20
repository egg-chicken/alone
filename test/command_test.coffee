assert = require('assert')
Command = require('models/command')
Character = require('models/board/character')

describe 'Command', ->
  describe '#useSkill', ->
    describe '手当', ->
      before ->
        @character = Character.createEnemy('葛籠鼠')
        @target    = Character.createEnemy('盲瓜坊')
        @command = Command.createUseSkill(@character, @target)

      it '体力が減っていない時失敗する', ->
        aid = => @command._useSkill()
        assert.throws(aid, Error)

      it '体力が減っている時成功し、対象を回復する', ->
        @target.damage(2)
        @command._useSkill()
        assert(@target.isHealthy())

      it '２回成功した後、それ以降常に失敗する', ->
        aid = =>
          @target.damage(2)
          @command._useSkill()
        aid()
        aid()
        assert.throws(aid, Error)
        assert.throws(aid, Error)
