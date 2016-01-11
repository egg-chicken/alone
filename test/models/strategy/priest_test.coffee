assert = require('assert')
Pair  = require('utils/pair')
BoardFactory = require('models/dungeon/board_factory')
Strategy = require('models/dungeon/strategy/')
Command  = require('models/dungeon/command/')

describe 'Strategy.Priest', ->
  beforeEach ->
    @board = BoardFactory.createHall(10, 10)
    @hero  = @board.createOne('主人公')
    @friend = @board.createOne('手甲虫')
    @enemy = @board.createOne('葛籠鼠')
    @strategy = new Strategy.Priest(@enemy)

  describe '#createCommand', ->
    describe '味方が隣接している時', ->
      beforeEach ->
        @friend.setPosition(new Pair(1, 1))
        @enemy.setPosition(new Pair(1, 2))
        @command = @strategy.createCommand(@board.inspectBy(@enemy))
      it 'スキルを使うこと', ->
        assert(@command instanceof Command.UseSkill)
      it '味方を対象に取ること', ->
        assert.equal(@command.target, @friend)

    describe '敵が隣接している時', ->
      beforeEach ->
        @hero.setPosition(new Pair(1, 1))
        @enemy.setPosition(new Pair(1, 2))
        @command = @strategy.createCommand(@board.inspectBy(@enemy))
      it '攻撃すること', ->
        assert(@command instanceof Command.Attack)
      it '主人公を対象に取ること', ->
        assert.equal(@command.target, @hero)
