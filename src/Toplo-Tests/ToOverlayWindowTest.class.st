"
A ToOverlayWindowTest is a test class for testing the behavior of ToOverlayWindow
"
Class {
	#name : 'ToOverlayWindowTest',
	#superclass : 'BlParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'running' }
ToOverlayWindowTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToOverlayWindowTest >> testWindowSize [

	| win e windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowHandler := ToOverlayWindowHandler new builder: [ :anchWin  :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace extent 
		equals: 10 asPoint.
	self
		assert: win root bounds inSpace extent 
		equals: 0 asPoint.

	e size: 20 asPoint.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace extent 
		equals: 20 asPoint.
	self
		assert: win root bounds inSpace extent 
		equals: 0 asPoint.


	
]

{ #category : 'tests' }
ToOverlayWindowTest >> testWindowSize2 [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowHandler := ToOverlayWindowHandler new builder: [ :anchWin  :element |
		anchWin root addChild: (ToElement new size: 100 asPoint) ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 10 asPoint.
	self assert: win root bounds inSpace extent equals: 100 asPoint.
	e size: 20 asPoint.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 20 asPoint.
	self assert: win root bounds inSpace extent equals: 100 asPoint
]
