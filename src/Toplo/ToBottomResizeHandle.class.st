Class {
	#name : #ToBottomResizeHandle,
	#superclass : #ToBorderResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToBottomResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self height: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors bottomAnchor on: gripTarget bottomAnchor).
			c anchors add:
				(c anchors leftAnchor on: gripTarget leftAnchor + self thickness).
			c anchors add: (c anchors widthAnchor on:
					 gripTarget widthAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToBottomResizeHandle >> cursorSelector [

	^ #resizeBottom
]

{ #category : #'mouse processing' }
ToBottomResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget extent:
		initialExtent x
		@ (initialExtent y + deltaFromInitialPosition y)
]
