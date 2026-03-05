Class {
	#name : #ToTopLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToTopLeftResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self constraintsDo: [ :c |
			c anchors add: (c anchors topLeftAnchor on:
					 anElement topLeftAnchor - self thickness asPoint) ]
]

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
