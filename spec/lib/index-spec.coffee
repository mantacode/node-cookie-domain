describe 'lib', ->
  
  Given -> @lib = requireSubject 'lib', {
    './../package.json':
      version: 1
  }

  describe '.version', ->

    When -> @version = @lib.version
    Then -> expect(@version).toEqual 1

  describe '#middleware', ->
    context 'req.cookieDomain is set', ->
      Given -> @subject = @lib()
      Given -> @req = {}
      Given -> @next = jasmine.createSpy 'next'

      context 'host is more than 2 parts', ->
        Given -> @req.host = 'banana.empire.com'
        When -> @subject @req, {}, @next
        Then -> expect(@req.cookieDomain).toBe '.empire.com'
        And -> expect(@next).toHaveBeenCalled()

      context 'host is 2 parts', ->
        Given -> @req.host = 'banana.com'
        When -> @subject @req, {}, @next
        Then -> expect(@req.cookieDomain).toBe 'banana.com'
        And -> expect(@next).toHaveBeenCalled()

  describe '#res.cookie', ->
    Given -> @cookie = jasmine.createSpy 'cookie'
    Given -> @req =
      host: 'foo.bar.com'
    Given -> @res =
      cookie: @cookie
    Given -> @next = jasmine.createSpy 'next'

    context 'defaults', ->
      When -> @lib()(@req, @res, @next)
      And -> @res.cookie 'session', 'some user'
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user',
        domain: '.bar.com'
        path: '/'
        maxAge: 31536000000

    context 'with config', ->
      When -> @lib({ path: '/something' })(@req, @res, @next)
      And -> @res.cookie 'session', 'some user'
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user',
        domain: '.bar.com'
        path: '/something'
        maxAge: 31536000000

    context 'with overrides', ->
      When -> @lib()(@req, @res, @next)
      And -> @res.cookie 'session', 'some user', { path: '/something/else' }
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user',
        domain: '.bar.com'
        path: '/something/else'
        maxAge: 31536000000

    context 'with config and overrides', ->
      When -> @lib({ path: '/a' })(@req, @res, @next)
      And -> @res.cookie 'session', 'some user', { path: '/b' }
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user',
        domain: '.bar.com'
        path: '/b'
        maxAge: 31536000000

    context 'with false as config', ->
      When -> @lib({ path: '/blah' })(@req, @res, @next)
      And -> @res.cookie 'session', 'some user', false
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user'

    context 'overriding maxAge with expires in overrides', ->
      When -> @lib()(@req, @res, @next)
      And -> @res.cookie 'session', 'some user', { expires: 'expires' }
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user',
        domain: '.bar.com'
        path: '/'
        expires: 'expires'

    context 'overriding expires with maxAge in overrides', ->
      When -> @lib({ expires: 'expires' })(@req, @res, @next)
      And -> @res.cookie 'session', 'some user', { maxAge: 'max' }
      Then -> expect(@cookie).toHaveBeenCalledWith 'session', 'some user',
        domain: '.bar.com'
        path: '/'
        maxAge: 'max'
        expires: 'expires'
