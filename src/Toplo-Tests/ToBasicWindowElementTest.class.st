"
A ToBasicWindowElementTest is a test class for testing the behavior of ToBasicWindowElement
"
Class {
	#name : #ToBasicWindowElementTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToBasicWindowElementTest >> testClose [

	| w |
	w := ToBasicWindowElement new.
	self assert: w isClosed.
	space root addChild: w.
	self deny: w isClosed.
	w close.
	self assert: w isClosed.
	self deny: w isOpened 

]

{ #category : #tests }
ToBasicWindowElementTest >> testDefaultElevation [ 

	| w |
	w := ToBasicWindowElement new.
	self assert: w elevation class identicalTo: w defaultElevation class.
	self assert: w elevation elevation identicalTo: w defaultElevation elevation.
	
]

{ #category : #tests }
ToBasicWindowElementTest >> testDefaultLayout [

	| w |
	w := ToBasicWindowElement new.
	self assert: w layout class identicalTo: w defaultLayout class
]

{ #category : #tests }
ToBasicWindowElementTest >> testInitialize [

	| w |
	w := ToBasicWindowElement new.
	self assert: (w root isKindOf: ToElement).
	self assert: w root identicalTo: w
]

{ #category : #tests }
ToBasicWindowElementTest >> testIsClosed [

	| w |
	w := ToBasicWindowElement new.
	self assert: w isClosed.
	space root addChild: w.
	self deny: w isClosed
]

{ #category : #tests }
ToBasicWindowElementTest >> testIsOpened [

	| w |
	w := ToBasicWindowElement new.
	self assert: w isClosed.
	space root addChild: w.
	self assert: w isOpened
]

{ #category : #tests }
ToBasicWindowElementTest >> testRoot [

	| w |
	w := ToBasicWindowElement new.
	self assert: w root identicalTo: w.

]

{ #category : #tests }
ToBasicWindowElementTest >> testToFront [

	| w |
	w := ToBasicWindowElement new.
	w toFront.
	self assert: w elevation class identicalTo: w defaultElevation class.
	self assert: w elevation elevation identicalTo: w defaultElevation elevation.
	self assert: w root elevation class identicalTo: w defaultElevation class.
	
]
