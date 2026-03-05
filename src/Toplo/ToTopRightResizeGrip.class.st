Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToTopRightResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self constraintsDo: [ :c |
		c anchors add:
			(c anchors topRightAnchor on: anElement topRightAnchor) ]
]

{ #category : #accessing }
ToTopRightResizeGrip >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #'mouse processing' }
ToTopRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x + deltaFromInitialPosition x
		@ (initialExtent y - deltaFromInitialPosition y)
]
