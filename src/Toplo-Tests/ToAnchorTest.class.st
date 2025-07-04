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
ToAnchorTest >> testActionAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a particular height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := child actionAnchor: [ :v :e | e position ].
	self waitTestingSpaces.

	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 10 @ 20.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 10 @ 20.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	child position: 0 @ 0.
	self waitTestingSpaces.
	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 0 @ 0.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ 0 corner: 100 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testHeightAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementHeightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 120.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 30).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: -20.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 100.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (15 @ 30 corner: 115 @ 40)
]

{ #category : #tests }
ToAnchorTest >> testNeutralAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a particular height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := child neutralAnchor: 0.
	self waitTestingSpaces.

	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 0.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	child position: 0 @ 0.
	self waitTestingSpaces.
	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 0.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ 0 corner: 100 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testNilAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a particular height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := child nilAnchor.
	self waitTestingSpaces.

	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: nil.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: nil.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	child position: 0 @ 0.
	self waitTestingSpaces.
	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: nil.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: nil.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ 0 corner: 100 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testWidthAnchorOnChild [
	" return the width of a rectangle or create a rectangle with a particular width according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementWidthAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 100.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 20 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).

	self
		assert:
		(anchor readRectangle:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: -10.
	self
		assert: (anchor readRectangle: child bounds asRectangle)
		equals: 90.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (15 @ 30 corner: 25 @ 150)
]
