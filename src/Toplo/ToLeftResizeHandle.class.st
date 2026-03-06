Class {
	#name : #ToLeftResizeHandle,
	#superclass : #ToBorderResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToLeftResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self width: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors leftAnchor on: gripTarget leftAnchor).
			c anchors add:
				(c anchors topAnchor on: gripTarget topAnchor + self thickness).
			c anchors add: (c anchors heightAnchor on:
					 gripTarget heightAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToLeftResizeHandle >> cursorSelector [

	^ #resizeLeft
]

{ #category : #'mouse processing' }
ToLeftResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	gripTarget extent:
		initialExtent x - deltaFromInitialPosition x
		@ initialExtent y
]
