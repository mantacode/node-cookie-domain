describe 'lib', ->
  
  Given -> @lib = requireSubject 'lib', {
    './../package.json':
      version: 1
  }

  describe '.version', ->

    When -> @version = @lib.version
    Then -> expect(@version).toEqual 1

  describe '#middleware', ->
    Given -> @subject = @lib()
    Given -> @req =
      get: jasmine.createSpy('get')
    Given -> @next = jasmine.createSpy 'next'

    context 'host is more than 2 parts', ->
      Given -> @req.get.when('host').thenReturn 'banana.empire.com'
      When -> @subject @req, {}, @next
      Then -> expect(@req.cookieDomain).toBe '.empire.com'
      And -> expect(@next).toHaveBeenCalled()

    context 'host is 2 parts', ->
      Given -> @req.get.when('host').thenReturn 'banana.com'
      When -> @subject @req, {}, @next
      Then -> expect(@req.cookieDomain).toBe 'banana.com'
      And -> expect(@next).toHaveBeenCalled()

