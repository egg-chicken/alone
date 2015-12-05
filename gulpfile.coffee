# FIXME: ドキュメントにないメソッド _initPaths() を使っている
process.env.NODE_PATH = "src/:build/:" + (process.env.NODE_PATH || "")
require('module')._initPaths()

gulp       = require("gulp")
coffee     = require("gulp-coffee")
mocha      = require("gulp-mocha")
browserify = require('browserify')

source     = require('vinyl-source-stream');
del        = require("del")

gulp.task "default", ->

gulp.task "clean", ->
  del("build/*")

gulp.task "build:coffee", ->
  gulp.src("src/**/*.coffee")
    .pipe(coffee())
    .pipe(gulp.dest("build"))

gulp.task "build:browserify", ->
  browserify(entries: 'build/core.js', debug: true)
    .bundle()
    .pipe(source('app.js'))
    .pipe(gulp.dest("build"))

gulp.task "build", ["build:coffee", "build:browserify"], ->

gulp.task "test", ->
  gulp.src('test/**/*_test.coffee', read: false)
    .pipe(mocha(reporter: 'spec'))
