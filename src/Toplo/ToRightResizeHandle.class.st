Class {
	#name : #ToRightResizeHandle,
	#superclass : #ToBorderResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToRightResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self width: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors rightAnchor on: gripTarget rightAnchor).
			c anchors add:
				(c anchors topAnchor on: gripTarget topAnchor + self thickness).
			c anchors add: (c anchors heightAnchor on:
					 gripTarget heightAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToRightResizeHandle >> cursorSelector [

	^ #resizeRight
]

{ #category : #'mouse processing' }
ToRightResizeHandle >> dragBy: deltaFromInitialPosition [

	gripTarget extent:
		initialExtent x + deltaFromInitialPosition x
		@ initialExtent y
]
