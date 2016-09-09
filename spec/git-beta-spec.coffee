path = require 'path'
gift = require 'gift'
git = require '../lib/git'

repo = gift path.join __dirname, '/fixture-repo'

describe "Git-Plus git module", ->
  describe "git.getConfig", ->
    it "retrieves the value for a key in git configs", ->
      repo.config (err, config) ->
        git.getConfig('user.name', repo.path)
        .then (value) -> expect(value).toBe config.items['user.name']
        .catch (error) -> expect(true).toBe false
