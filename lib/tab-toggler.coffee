{CompositeDisposable} = require 'atom'

module.exports = MyTabToggler =
  discriminator: '.tab-bar'
  toggleClass: 'hidden'

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tab-toggler:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()

  getPanes: ->
    tabBars = []
    for pane, i in atom.workspace.getPanes()
      tabBars.push(atom.views.getView(pane).querySelector(@discriminator));

    return tabBars

  toggle: ->
    for tabBar in @getPanes()
      # Keep the tabBars in sync by determining the state of the first occurence.
      if assertFirstTabBar is undefined
        assertFirstTabBar = tabBar.classList.contains(@toggleClass)
      # Toggle the tabBar
      if assertFirstTabBar
        tabBar.classList.remove(@toggleClass);
      else
        tabBar.classList.add(@toggleClass);
