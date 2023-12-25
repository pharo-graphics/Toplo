"
A ToBasicWindowElementTest is a test class for testing the behavior of ToBasicWindowElement
"
Class {
	#name : #ToBasicWindowElementTest,
	#superclass : #ToTestCaseWithSpace,
	#category : 'Toplo-Tests-Core-Window'
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
ToBasicWindowElementTest >> testDefaultRootElement [

	| w |
	w := ToBasicWindowElement new.
	self assert: w root layout class identicalTo: w defaultRootElement layout class.
	self assert: w root id equals: w defaultRootId
]

{ #category : #tests }
ToBasicWindowElementTest >> testInitialize [

	| w |
	w := ToBasicWindowElement new.
	self assert: (w root isKindOf: ToElement).
	self assert: w root parent identicalTo: w
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

	| w r prev |
	w := ToBasicWindowElement new.
	prev := w root.
	r := ToElement new.
	w root: r.
	self assert: w root identicalTo: r.
	self assert: prev parent isNil
]

{ #category : #tests }
ToBasicWindowElementTest >> testRootLayout [

	| w l |
	w := ToBasicWindowElement new.
	l := BlLinearLayout horizontal.
	w rootLayout: l.
	self assert: w rootLayout identicalTo: l
]

{ #category : #tests }
ToBasicWindowElementTest >> testToFront [

	| w |
	w := ToBasicWindowElement new.
	w toFront.
	self assert: w elevation class identicalTo: w defaultElevation class.
	self assert: w elevation elevation identicalTo: w defaultElevation elevation.
	self assert: w root elevation class identicalTo: w defaultElevation class.
	self assert: w root elevation elevation identicalTo: w defaultElevation elevation.
	
]
