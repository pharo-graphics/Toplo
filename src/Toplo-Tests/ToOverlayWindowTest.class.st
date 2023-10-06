"
A ToOverlayWindowTest is a test class for testing the behavior of ToOverlayWindow
"
Class {
	#name : #ToOverlayWindowTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToOverlayWindowTest >> testWindowSize [

	| win e space |
	space := self newTestingSpace.
	e := ToAnchoredWindowElementForTest new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToOverlayWindow new associateElement: e.
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

{ #category : #tests }
ToOverlayWindowTest >> testWindowSize2 [

	| win e space |
	space := self newTestingSpace.
	e := ToAnchoredWindowElementForTest new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToOverlayWindow new associateElement: e.
	win root addChild: (ToElement new size: 100 asPoint ).
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace extent 
		equals: 10 asPoint.
	self
		assert: win root bounds inSpace extent 
		equals: 100 asPoint.
	e size: 20 asPoint.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace extent 
		equals: 20 asPoint.
	self
		assert: win root bounds inSpace extent 
		equals: 100 asPoint.


	
]
