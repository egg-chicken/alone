module.exports = class Stage
  @Scenes: {}
  goto: (name, onCompleted, onFailed = null)->
    @scene.destruct() if @scene?
    @scene = @_createScene(name)
    @scene.on('completed', onCompleted)
    @scene.on('failed', onFailed) if onFailed?
    @scene.play()

  _createScene: (name)->
    klass = Stage.Scenes[name]
    if klass
      new klass()
    else
      throw new Error("please set Stage.Scene.#{name}")
