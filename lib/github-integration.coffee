GithubIntegrationView = require './github-integration-view'
{CompositeDisposable} = require 'atom'

module.exports = GithubIntegration =
  githubIntegrationView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @githubIntegrationView = new GithubIntegrationView(state.githubIntegrationViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @githubIntegrationView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'github-integration:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @githubIntegrationView.destroy()

  serialize: ->
    githubIntegrationViewState: @githubIntegrationView.serialize()

  toggle: ->
    console.log 'GithubIntegration was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
