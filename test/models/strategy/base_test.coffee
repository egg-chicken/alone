assert = require('assert')
sinon = require('sinon')
Pair  = require('utils/pair')
BoardFactory = require('models/dungeon/board_factory')
Strategy = require('models/dungeon/strategy/base')

describe 'Strategy.Base', ->
  beforeEach ->
    @board = BoardFactory.createHall(10, 10)
    @hero  = @board.createOne('主人公')
    @enemy = @board.createOne('盲瓜坊')
    @strategy = new Strategy(@enemy)
    @strategy.inspector = @board.inspectBy(@enemy)

  describe '#_approach', ->
    beforeEach ->
      @hero.setPosition(new Pair(1, 1))
      @enemy.setPosition(new Pair(3, 3))
    it '対象に近づく方向に移動すること', ->
      old_distance = @hero.distance(@enemy)
      command = @strategy._approach(@hero)
      command.perform(@board)
      new_distance = @hero.distance(@enemy)
      assert.equal(new_distance, old_distance - 1)

  describe '#_attack', ->
    it '対象を攻撃すること', ->
      command = @strategy._attack(@hero)
      command.perform(@board)
      assert(not @hero.isHealthy())

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
