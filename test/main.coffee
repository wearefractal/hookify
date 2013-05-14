hookify = require '../'
should = require 'should'
require 'mocha'

describe 'hookify', ->
  describe 'constructor', ->
    it 'should create', (done) ->
      test = new hookify
      should.exist test
      should.exist test.pres
      should.exist test.posts
      done()

  describe 'pre', ->
    it 'should add a listener', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.pre 'handle', handlerFn
      should.exist test.pres
      should.exist test.pres.handle
      test.pres.handle.length.should.equal 1
      test.pres.handle[0].should.equal handlerFn
      done()

    it 'should remove a listener', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.pre 'handle', handlerFn
      test.removePre 'handle', handlerFn

      should.exist test.pres
      should.exist test.pres.handle
      test.pres.handle.length.should.equal 0
      done()

    it 'should call a listener when triggered', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.pre 'handle', handlerFn
      
      test.runPre 'handle', [1,2], (err) ->
        should.not.exist err
        done()

    it 'should call multiple listeners when triggered', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.pre 'handle', handlerFn
      test.pre 'handle', handlerFn

      test.runPre 'handle', [1,2], (err) ->
        should.not.exist err
        done()

    it 'should call not run listeners after error', (done) ->
      test = new hookify
      run = false
      handlerFn = (num, othernum, next) ->
        throw "Run twice!" if run is true
        run = true
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next "Broken!"

      test.pre 'handle', handlerFn
      test.pre 'handle', handlerFn

      test.runPre 'handle', [1,2], (err) ->
        should.exist err
        err.should.equal "Broken!"
        done()

  describe 'post', ->
    it 'should add a listener', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.post 'handle', handlerFn
      should.exist test.posts
      should.exist test.posts.handle
      test.posts.handle.length.should.equal 1
      test.posts.handle[0].should.equal handlerFn
      done()

    it 'should remove a listener', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.post 'handle', handlerFn
      test.removePost 'handle', handlerFn

      should.exist test.posts
      should.exist test.posts.handle
      test.posts.handle.length.should.equal 0
      done()

    it 'should call a listener when triggered', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.post 'handle', handlerFn
      
      test.runPost 'handle', [1,2], (err) ->
        should.not.exist err
        done()

    it 'should call multiple listeners when triggered', (done) ->
      test = new hookify
      handlerFn = (num, othernum, next) ->
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next()

      test.post 'handle', handlerFn
      test.post 'handle', handlerFn

      test.runPost 'handle', [1,2], (err) ->
        should.not.exist err
        done()

    it 'should call not run listeners after error', (done) ->
      test = new hookify
      run = false
      handlerFn = (num, othernum, next) ->
        throw "Run twice!" if run is true
        run = true
        should.exist num
        should.exist othernum
        num.should.equal 1
        othernum.should.equal 2
        next "Broken!"

      test.post 'handle', handlerFn
      test.post 'handle', handlerFn

      test.runPost 'handle', [1,2], (err) ->
        should.exist err
        err.should.equal "Broken!"
        done()