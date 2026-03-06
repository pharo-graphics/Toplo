Class {
	#name : #ToBottomRightResizeHandle,
	#superclass : #ToCornerResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToBottomRightResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self constraintsDo: [ :c |
			c anchors add:
				(c anchors bottomRightAnchor on: gripTarget bottomRightAnchor) ]
]

{ #category : #accessing }
ToBottomRightResizeHandle >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #'mouse processing' }
ToBottomRightResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget extent:
		initialExtent + deltaFromInitialPosition
]
