Class {
	#name : #ToBottomLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToBottomLeftResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self constraintsDo: [ :c |
			c anchors add:
				(c anchors bottomLeftAnchor on: anElement bottomLeftAnchor) ]
]

{ #category : #accessing }
ToBottomLeftResizeGrip >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : #'mouse processing' }
ToBottomLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement extent:
		initialExtent x - deltaFromInitialPosition x
		@ (initialExtent y + deltaFromInitialPosition y)
]
