Class {
	#name : #ToTopLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #accessing }
ToTopLeftResizeGrip >> cursorSelector [

	^ #resizeTopLeft
]

{ #category : #'mouse processing' }
ToTopLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x - deltaFromInitialPosition x
		@ (initialExtent y - deltaFromInitialPosition y)
]

{ #category : #'mouse processing' }
ToTopLeftResizeGrip >> layoutGripTarget: anElement [

	super layoutGripTarget: anElement.
	self position: (thickness @ thickness) negated
]
