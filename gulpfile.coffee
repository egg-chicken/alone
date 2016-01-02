# FIXME: ドキュメントにないメソッド _initPaths() を使っている
process.env.NODE_PATH = "src/:build/:" + (process.env.NODE_PATH || "")
require('module')._initPaths()

gulp       = require("gulp")
coffee     = require("gulp-coffee")
mocha      = require("gulp-mocha")
uglify     = require("gulp-uglify")

browserify = require("browserify")
source     = require('vinyl-source-stream')
buffer     = require('vinyl-buffer')
del        = require("del")

gulp.task "default", ->

gulp.task "clean", ->
  del("build/*")

gulp.task "build:coffee", ['clean'], ->
  gulp.src("src/**/*.coffee")
    .pipe(coffee(bare: true))
    .pipe(gulp.dest("build"))

gulp.task "build:browserify", ->
  browserify(entries: 'build/core.js', debug: true)
    .bundle()
    .pipe(source('app.js'))
    .pipe(gulp.dest("build"))

gulp.task "build:minify", ->
  browserify(entries: 'build/core.js', debug: true)
    .bundle()
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(uglify())
    .pipe(gulp.dest("build"))

gulp.task "build:develop", ["build:coffee"], ->
  gulp.start("build:browserify")

gulp.task "build", ["build:coffee"], ->
  gulp.start("build:minify")

gulp.task "test", ->
  gulp.src('test/**/*_test.coffee', read: false)
    .pipe(mocha(reporter: 'spec'))
