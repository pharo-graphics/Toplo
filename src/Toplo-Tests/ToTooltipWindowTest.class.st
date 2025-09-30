"
A ToTooltipWindowTest is a test class for testing the behavior of ToTooltipWindow
"
Class {
	#name : #ToTooltipWindowTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Tooltip'
}

{ #category : #tests }
ToTooltipWindowTest >> testContent [

	| e windowManager |
	e := ToElement new extent: 100 @ 100.
	e tooltipContent: (ToLabel text: 'Tooltip content').
	windowManager := e tooltipWindowManager.
	self assert: (windowManager isKindOf: ToTooltipPopupManager).
	space root addChild: e.

	BlSpace simulateMouseMoveInside: e.
	self waitTestingSpaces.
	900 milliSecond wait.
	self waitTestingSpaces.

	self assert:
		(windowManager currentWindow root firstChild isKindOf: ToLabel).
	self
		assert: windowManager currentWindow root firstChild text asString
		equals: 'Tooltip content'.
	^ windowManager currentWindow
]

{ #category : #tests }
ToTooltipWindowTest >> testCurrentWindow [

	| window |
	
	window := self testContent.
	self assert: window isOpened.
	self assert: window notNil.
	self assert: window isOpened.

]

{ #category : #tests }
ToTooltipWindowTest >> testDefaultElevation [

	| window |
	window := self testContent.
	self
		assert: window  elevation elevation
		equals: window  defaultElevation elevation
]

{ #category : #tests }
ToTooltipWindowTest >> testInitialize [

	| w |
	w := ToTooltipWindow new.
	self deny: w hasManager
]
