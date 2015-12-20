assert = require('assert')
CharacterFactory = require('models/dungeon/board/character_factory')

describe 'CharacterFactory', ->
  describe '#create', ->
    it '引数で指定したキャラクターが生成されること', ->
      monster = CharacterFactory.create(3)
      assert.equal(monster.type, 3)

  describe '#createHero', ->
    it '主人公が生成されること', ->
      hero = CharacterFactory.createHero()
      assert(hero.isHero())

  describe '#createByName', ->
    it '引数で指定したキャラクターが生成されること', ->
      monster = CharacterFactory.createByName("手甲虫")
      assert.equal(monster.type, 2)

    it '未知の名前のキャラクターを作成しようとした時エラーになること', ->
      create = => CharacterFactory.createByName("SPECIAL-UNKNOWN-CHARACTER")
      assert.throws(create, /unknown character:/)

  describe '#createBySlot', ->
    it 'テーブルパターンに応じた敵が生成されること', ->
      CharacterFactory.slot = [2,2,2,2,2,2]
      monster = CharacterFactory.createBySlot()
      assert.equal(monster.type, 2)
