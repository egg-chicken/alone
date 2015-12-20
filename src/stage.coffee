Scenes = require('./scenes/')

module.exports = class Stage
  goto: (name, onCompleted, onFailed = null)->
    @scene.destruct() if @scene?
    @scene = new Scenes[name]()
    @scene.on('completed', onCompleted)
    @scene.on('failed', onFailed) if onFailed?
    @scene.play()
