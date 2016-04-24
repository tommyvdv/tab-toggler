MyTabToggler = require '../lib/tab-toggler'

# Very simple test to see if the tab bar is effectively hidden and/or toggled.
# @dependsOn package tabs
#
# Activating the tab bar will show it.
# Using the tab toggler will hide it.
# Using the tab toggler again will show it.
# Conclusion: invoke any even number of times to hide and odd to show.

describe "MyTabToggler", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('tab-toggler')
    waitsForPromise ->
      atom.packages.activatePackage("tabs")

  describe "when the tab-toggler:toggle event is triggered", ->
    it "an odd number off times hides the tab bar(s)", ->
      jasmine.attachToDOM(workspaceElement)
      for i in [0...generateEvenNumber(1,10)]
        atom.commands.dispatch workspaceElement, 'tab-toggler:toggle'
      runs ->
        expect(workspaceElement.querySelector('.tab-bar')).toExist()
        expect(workspaceElement.querySelector('.tab-bar')).toBeVisible()

    it "an even number of times shows the tab bar(s)", ->
      jasmine.attachToDOM(workspaceElement)
      for i in [0...generateOddNumber(1,10)]
        atom.commands.dispatch workspaceElement, 'tab-toggler:toggle'
      runs ->
        expect(workspaceElement.querySelector('.tab-bar')).toExist()
        expect(workspaceElement.querySelector('.tab-bar')).not.toBeVisible()

# A little help coming up with numbers.

generateOddNumber = (min, max) ->
  randomNumber = generateNumber(min, max)
  return randomNumber + (isOdd(randomNumber) ? -1 : 0)
generateNumber = (min, max) -> Math.floor(Math.random() * (max - min + 1)) + min
generateEvenNumber = (min, max) -> generateOddNumber(min, max) + 1
isEven = (num) -> num % 2 ? true : false
isOdd = (num) -> !isEven(num)
