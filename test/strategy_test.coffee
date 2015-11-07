assert = require('assert')
sinon = require('sinon')
Board = require('models/board')
Strategy = require('models/player/strategy')

describe 'Strategy', ->
  beforeEach ->
    @board = Board.createHall(10, 10)
    @hero  = @board.createOne('主人公')

  describe '#_useSkill', ->
    describe '射程1の時', ->
      beforeEach ->
        @character = @board.createOne('盲瓜坊')
        @strategy = new Strategy(@character)
        @strategy.inspector = @board.inspectBy(@character)
      it '主人公を対象に取ること', ->
        command = @strategy._useSkill()
        assert.equal(command.target, @hero)

    describe '射程0の時', ->
      beforeEach ->
        @character = @board.createOne('手甲虫')
        @strategy = new Strategy(@character)
        @strategy.inspector = @board.inspectBy(@character)
      it '自身を対象に取ること', ->
        command = @strategy._useSkill()
        assert.equal(command.target, @character)

  describe '#_attackOrUseSkill', ->
    beforeEach ->
      @character = @board.createOne('手甲虫')
      @strategy = new Strategy(@character)
      @strategy.inspector = @board.inspectBy(@character)
      sinon.spy(@strategy, '_useSkill')

    it '確率に従ってスキルを使用すること', ->
      for i in [0...100]
        @strategy._attackOrUseSkill()
      d = @strategy._useSkill.callCount / 100 -  1 / 4
      assert(-0.1 < d && d < 0.1)
