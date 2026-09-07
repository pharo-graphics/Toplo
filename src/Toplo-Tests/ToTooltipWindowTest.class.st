"
A ToTooltipWindowTest is a test class for testing the behavior of ToTooltipWindow
"
Class {
	#name : #ToTooltipWindowTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Tooltip'
}

{ #category : #tests }
ToTooltipWindowTest >> setUpTooltipWindow [

	| element windowManager |
	element := ToElement new.
	element extent: 100 @ 100.
	element tooltipBuilder: [ :win :request |
		win root addChild: (ToLabel text: 'Tooltip content') ].

	windowManager := element ensuredTooltipManager.
	windowManager popupDelay: 10 milliSeconds.

	space deferAndSettle: [ space root addChild: element ].

	element eventSimulator mouseMoveInside.
	space waitUntilTrue: [
		windowManager currentWindow notNil and: [
			windowManager currentWindow isOpened ] ].

	^ windowManager currentWindow
]

{ #category : #tests }
ToTooltipWindowTest >> testContent [

	| tooltipWindow |
	tooltipWindow := self setUpTooltipWindow.
	self
		assert: tooltipWindow root firstChild class
		equals: ToLabel.
	self
		assert: tooltipWindow root firstChild text asString
		equals: 'Tooltip content'
]

{ #category : #tests }
ToTooltipWindowTest >> testCurrentWindow [

	| tooltipWindow |
	tooltipWindow := self setUpTooltipWindow.
	self assert: tooltipWindow notNil.
	self assert: tooltipWindow isOpened
]

{ #category : #tests }
ToTooltipWindowTest >> testDefaultElevation [

	| tooltipWindow |
	tooltipWindow := self setUpTooltipWindow.
	self
		assert: tooltipWindow elevation elevation
		equals: tooltipWindow defaultElevation elevation
]

{ #category : #tests }
ToTooltipWindowTest >> testInitialize [

	self deny: ToTooltipWindow new hasManager
]
