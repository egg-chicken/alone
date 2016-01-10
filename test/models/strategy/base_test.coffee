assert = require('assert')
sinon = require('sinon')
BoardFactory = require('models/dungeon/board_factory')
Strategy = require('models/dungeon/strategy/base')

describe 'Strategy.Base', ->
  beforeEach ->
    @board = BoardFactory.createHall(10, 10)
    @hero  = @board.createOne('主人公')
    @enemy = @board.createOne('盲瓜坊')
    @strategy = new Strategy(@enemy)
    @strategy.inspector = @board.inspectBy(@enemy)


  describe '#_useSkill', ->
    describe '射程1の時', ->
      beforeEach ->
        @enemy.skillRange = 1
      it '主人公を対象に取ること', ->
        command = @strategy._useSkill()
        assert.equal(command.target, @hero)

    describe '射程0の時', ->
      beforeEach ->
        @enemy.skillRange = 0
      it '自身を対象に取ること', ->
        command = @strategy._useSkill()
        assert.equal(command.target, @enemy)

  describe '#_attackOrUseSkill', ->
    beforeEach ->
      sinon.spy(@strategy, '_useSkill')

    it '確率に従ってスキルを使用すること', ->
      for i in [0...100]
        @strategy._attackOrUseSkill()
      d = @strategy._useSkill.callCount / 100 -  1 / 4
      assert(-0.1 < d && d < 0.1)
