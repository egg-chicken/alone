DungeonScene = require('./scenes/dungeon_scene')

scene = new DungeonScene()
scene.play()
scene.onComplete = (status)->
  console.log(status)
  scene.destruct()
  process.exit()
