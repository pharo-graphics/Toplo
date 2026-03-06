Class {
	#name : #ToTopResizeHandle,
	#superclass : #ToBorderResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToTopResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self height: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors topAnchor on: gripTarget topAnchor).
			c anchors add:
				(c anchors leftAnchor on: gripTarget leftAnchor + self thickness).
			c anchors add: (c anchors widthAnchor on:
					 gripTarget widthAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToTopResizeHandle >> cursorSelector [

	^ #resizeTop
]

{ #category : #'mouse processing' }
ToTopResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	gripTarget extent:
		initialExtent x
		@ (initialExtent y - deltaFromInitialPosition y)
]
