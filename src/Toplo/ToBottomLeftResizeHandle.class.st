Class {
	#name : #ToBottomLeftResizeHandle,
	#superclass : #ToCornerResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToBottomLeftResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self constraintsDo: [ :c |
			c anchors add:
				(c anchors bottomLeftAnchor on: gripTarget bottomLeftAnchor) ]
]

{ #category : #accessing }
ToBottomLeftResizeHandle >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : #'mouse processing' }
ToBottomLeftResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	gripTarget extent:
		initialExtent x - deltaFromInitialPosition x
		@ (initialExtent y + deltaFromInitialPosition y)
]
