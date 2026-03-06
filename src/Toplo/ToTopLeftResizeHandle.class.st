Class {
	#name : #ToTopLeftResizeHandle,
	#superclass : #ToCornerResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToTopLeftResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self constraintsDo: [ :c |
			c anchors add: (c anchors topLeftAnchor on:
					 gripTarget topLeftAnchor - self thickness asPoint) ]
]

{ #category : #accessing }
ToTopLeftResizeHandle >> cursorSelector [

	^ #resizeTopLeft
]

{ #category : #'mouse processing' }
ToTopLeftResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget position:
		initialPosition x + deltaFromInitialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	gripTarget extent:
		initialExtent x - deltaFromInitialPosition x
		@ (initialExtent y - deltaFromInitialPosition y)
]
