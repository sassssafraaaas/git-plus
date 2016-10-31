Path = require 'path'

module.exports = (repo) ->
  atom.workspace.open Path.join(repo.getWorkingDirectory(), '.git/info/excludes')
