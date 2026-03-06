Class {
	#name : #ToTopRightResizeHandle,
	#superclass : #ToCornerResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToTopRightResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self constraintsDo: [ :c |
		c anchors add:
			(c anchors topRightAnchor on: gripTarget topRightAnchor) ]
]

{ #category : #accessing }
ToTopRightResizeHandle >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #'mouse processing' }
ToTopRightResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	gripTarget extent:
		initialExtent x + deltaFromInitialPosition x
		@ (initialExtent y - deltaFromInitialPosition y)
]
