Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #accessing }
ToBottomRightResizeGrip >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #initialization }
ToBottomRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent + deltaFromInitialPosition
]

{ #category : #initialization }
ToBottomRightResizeGrip >> layoutIn: anElement [

	super layoutIn: anElement.
	self position: anElement extent - (thickness @ thickness)
]
