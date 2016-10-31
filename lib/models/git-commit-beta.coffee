gift = require 'gift'
{View} = require 'space-pen'
{ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'

git = require '../git'
notifier = require '../notifier'

disposables = new CompositeDisposable

letterToStatusMap =
  A: 'added'
  D: 'deleted'
  M: 'modified'

class StatusListView extends View
  @content: (files) ->
    @div =>
      for path, file of files
        @div =>
          @p "#{letterToStatusMap[file.type]}  #{path}"

class CommitView extends ScrollView
  @content: ({files})->
    @div class: 'git-plus', =>
      @subview 'commitMessage',  new TextEditorView(placeholderText: 'Enter your commit here...')
      @subview 'status', new StatusListView(files)

  initialize: (changes) ->
    super
    # TODO: It seems like core:save can't be invoked on TextEditorView and it's TextBuffer
    console.debug @commitMessage.getModel()
    @commitMessage.getModel().getBuffer().setPath('/temp/foo')
    atom.commands.add @commitMessage.getModel().getElement(), 'core:save', () => console.log('saving?')
    # @commitMessage.getModel().onWillSave () => console.log('saving?...')

module.exports = (repo, {stageChanges, andPush}={}) ->
  currentPane = atom.workspace.getActivePane()
  repository = gift repo.getWorkingDirectory()

  repository.status (err, status) ->
    atom.workspace.addTopPanel(item: new CommitView(files: status.files))
