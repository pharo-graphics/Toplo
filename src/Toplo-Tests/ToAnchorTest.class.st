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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 10 @ 20.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 0 @ 0.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ 0 corner: 100 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testBottomAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementBottomAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 140.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: (Rectangle origin: 0 asPoint corner: 0 asPoint) withValue: 10)
		equals: (10 @ -110 corner: 110 @ 10)
]

{ #category : #tests }
ToAnchorTest >> testBottomLeftAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child size: 100 @ 120.

	anchor := ToElementBottomLeftAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 110@140.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-100 @ -120 corner: 0 @ 0).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 110@140.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-100 @ -120 corner: 0 @ 0)
]

{ #category : #tests }
ToAnchorTest >> testBottomRightAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child size: 100 @ 120.

	anchor := ToElementBottomRightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210@140.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-200 @ -120 corner: -100 @ 0).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210@140.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-200 @ -120 corner: -100 @ 0)
]

{ #category : #tests }
ToAnchorTest >> testExtentAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child size: 100 @ 120.

	anchor := ToElementExtentAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 100@120.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (110 @ 20 corner: 120 @ 40).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0 @ 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 100@120.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (110 @ 20 corner: 120 @ 40)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 120.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 30).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: -20.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 100.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (15 @ 30 corner: 115 @ 40)
]

{ #category : #tests }
ToAnchorTest >> testHorizontalCenterAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementHorizontalCenterAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 60.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (-40 @ 20 corner: 60.0 @ 140.0).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 60.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (-40 @ 20 corner: 60 @ 140)
]

{ #category : #tests }
ToAnchorTest >> testLeftAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementLeftAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 10.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: -5.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 5.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: nil.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: nil.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: nil.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ 0 corner: 100 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testRightAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child size: 100 @ 120.

	anchor := ToElementRightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (-90 @ 20 corner: 10 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 5.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 215.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (-90 @ 20 corner: 10 @ 140)
]

{ #category : #tests }
ToAnchorTest >> testTopAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementTopAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 20.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 10 corner: 110 @ 130).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: -10.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 10.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 10 corner: 110 @ 130)
]

{ #category : #tests }
ToAnchorTest >> testTopLeftAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child size: 100 @ 120.

	anchor := ToElementTopLeftAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 110@20.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-100 @ 0 corner: 0 @ 120).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 110@20.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-100 @ 0 corner: 0 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testTopRightAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child size: 100 @ 120.

	anchor := ToElementTopRightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210@20.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-200 @ 0 corner: -100 @ 120).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0@0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210@20.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10@20)
		equals: (-200 @ 0 corner: -100 @ 120)
]

{ #category : #tests }
ToAnchorTest >> testVerticalCenterAnchorOnChild [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child size: 100 @ 120.

	anchor := ToElementVerticalCenterAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 80.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ -50 corner: 110 @ 70).

	child margin: (BlInsets horizontal: 5 vertical: 10).
	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 80.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ -50 corner: 110 @ 70)
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
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 100.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 20 @ 140).

	child margin: (BlInsets horizontal: 5 vertical: 10).

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: -10.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 90.
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (15 @ 30 corner: 25 @ 150)
]
