{CompositeDisposable} = require 'atom'

module.exports = MyTabToggler =
  tabPackagename: 'tabs'

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'tab-toggler:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()

  isDisabled: ->
    return atom.packages.isPackageDisabled(@tabPackagename)

  enable: ->
    atom.packages.enablePackage(@tabPackagename)

  disable: ->
    atom.packages.disablePackage(@tabPackagename)

  toggle: ->
    if (@isDisabled())
      @enable()
    else
      @disable()
