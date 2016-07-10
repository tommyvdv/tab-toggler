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

      oddNumberBetween = generateOddNumberBetween(1,10)
      triggerEventTimesX(
        oddNumberBetween,
        workspaceElement,
        'tab-toggler:toggle'
      )

      runs ->
        expect(atom.packages.isPackageDisabled('tabs')).toBe true

    it "an even number of times shows the tab bar(s)", ->
      jasmine.attachToDOM(workspaceElement)

      evenNumberBetween = generateEvenNumberBetween(1,10)
      triggerEventTimesX(
        evenNumberBetween,
        workspaceElement,
        'tab-toggler:toggle'
      )

      runs ->
        expect(atom.packages.isPackageDisabled('tabs')).toBe false

# A little help coming up with numbers.
generateOddNumberBetween = (min, max) ->
  randomNumberBetween = generateNumberBetween(min, max)
  return randomNumberBetween + (isOdd(randomNumberBetween) ? -1 : 0)
generateNumberBetween = (min, max) -> Math.floor(Math.random() * (max - min + 1)) + min
generateEvenNumberBetween = (min, max) -> generateOddNumberBetween(min, max) + 1
isEven = (num) -> num % 2 ? true : false
isOdd = (num) -> !isEven(num)
triggerEventTimesX = (numberOfTimes, element, event) ->
  for i in [0...numberOfTimes]
    atom.commands.dispatch element, event
