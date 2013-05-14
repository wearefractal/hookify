async = require 'async'

class hookify
  constructor: ->
    @pres = {}
    @posts = {}

  pre: (evt, fn) ->
    @pres[evt] ?= []
    @pres[evt].push fn
    return @

  post: (evt, fn) ->
    @posts[evt] ?= []
    @posts[evt].push fn
    return @

  removePre: (evt, fn) ->
    @pres[evt].splice @pres[evt].indexOf(fn), 1
    return @

  removePost: (evt, fn) ->
    @posts[evt].splice @posts[evt].indexOf(fn), 1
    return @

  runPre: (evt, args, cb) =>
    return cb() unless @pres[evt]? and @pres[evt].length isnt 0
    run = (middle, done) => middle args..., done
    async.forEachSeries @pres[evt], run, cb
    return @

  runPost: (evt, args, cb) =>
    return cb() unless @posts[evt]? and @posts[evt].length isnt 0
    run = (middle, done) => middle args..., done
    async.forEachSeries @posts[evt], run, cb
    return @

module.exports = hookify