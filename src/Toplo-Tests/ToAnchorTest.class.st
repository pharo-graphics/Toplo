Class {
	#name : #ToAnchorTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'child',
		'parent'
	],
	#category : #'Toplo-Tests-Support-Anchor'
}

{ #category : #running }
ToAnchorTest >> setUp [ 

	super setUp.
	parent := ToPane new.
	parent matchParent.
	parent layout: ToAnchorLayout new.
	space root addChild: parent.
	child := ToElement new.
	parent addChild: child
	
]

{ #category : #tests }
ToAnchorTest >> testHeightAnchorOnChild [

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementHeightAnchor new
		          element: child;
		          yourself.
		
	self waitTestingSpaces.
	
	self assert: (anchor readRectangle: child bounds asRectangle) equals: 120.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 30).

	child margin: (BlInsets all: 5).

	self assert: (anchor readRectangle: child bounds asRectangle) equals: 110.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (15 @ 25 corner: 115 @ 35).

]

{ #category : #tests }
ToAnchorTest >> testWidthAnchorOnChild [

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementWidthAnchor new
		          element: child;
		          yourself.
		
	self waitTestingSpaces.
	
	self assert: (anchor readRectangle: child bounds asRectangle) equals: 100.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 20 @ 140).
		
	child margin: (BlInsets all: 5).

	self assert: (anchor readRectangle: child bounds asRectangle) equals: 90.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (15 @ 25 corner: 25 @ 145).

]
