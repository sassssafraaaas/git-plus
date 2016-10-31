Path = require 'path'
{repo} = require '../fixtures'
GitEditExcludes = require '../../lib/models/git-edit-excludes'

describe "GitEditExcludes", ->
  it "opens excludes file", ->
    spyOn(atom.workspace, 'open')
    GitEditExcludes(repo)
    expect(atom.workspace.open).toHaveBeenCalledWith(Path.join(repo.getWorkingDirectory(), '.git/info/excludes'))
