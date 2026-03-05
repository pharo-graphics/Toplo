Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToBottomRightResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self constraintsDo: [ :c |
			c anchors add:
				(c anchors bottomRightAnchor on: anElement bottomRightAnchor) ]
]

{ #category : #accessing }
ToBottomRightResizeGrip >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #'mouse processing' }
ToBottomRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent + deltaFromInitialPosition
]
