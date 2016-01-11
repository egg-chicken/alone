assert = require('assert')
Pair  = require('utils/pair')
Array2D = require('utils/array2d')
BoardFactory = require('models/dungeon/board_factory')
Strategy = require('models/dungeon/strategy/')
Command  = require('models/dungeon/command/')

describe 'Strategy.Traveler', ->
  beforeEach ->
    a = 'a'.charCodeAt()
    b = 'b'.charCodeAt()
    table = Array2D.create([
      [0,0,0,0,0,0,0,0,0,0]
      [0,a,a,a,0,0,0,b,b,0]
      [0,a,a,a,1,2,0,b,b,0]
      [0,a,a,a,0,2,1,b,b,0]
      [0,0,0,0,0,0,0,0,0,0]
    ])
    @board = BoardFactory.createWithLandTable(table)
    @hero = @board.createOne('主人公')
    @enemy = @board.createOne('盲瓜坊')
    @friend = @board.createOne('盲瓜坊')
    @strategy = new Strategy.Traveler(@enemy)

  describe '#createCommand', ->
    describe '敵が隣接している時', ->
      beforeEach ->
        @hero.setPosition(new Pair(1, 1))
        @enemy.setPosition(new Pair(1, 2))
        @command = @strategy.createCommand(@board.inspectBy(@enemy))
      it '攻撃またはスキルを使うこと', ->
        assert((@command instanceof Command.Attack) || (@command instanceof Command.UseSkill))
      it '主人公を対象に取ること', ->
        assert.equal(@command.target, @hero)

    describe '敵が別の部屋にいる時', ->
      beforeEach ->
        @hero.setPosition(new Pair(1, 1))
        @enemy.setPosition(new Pair(7, 1))
        @command = @strategy.createCommand(@board.inspectBy(@enemy))
      it '移動すること', ->
        assert(@command instanceof Command.Move)
      it '部屋の扉に向かうこと', ->
        assert.equal(@command.direction, 'down')

    describe '進行方向に仲間がいる時', ->
      beforeEach ->
        p = new Pair(5, 2)
        @enemy.setPosition(p)
        @friend.setPosition(p.left())
        @strategy.prevPosition = p.down()
        @command = @strategy.createCommand(@board.inspectBy(@enemy))
      it '移動すること', ->
        assert(@command instanceof Command.Move)
      it '引き返すこと', ->
        assert.equal(@command.direction, 'down')
