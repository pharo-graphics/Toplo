Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToBottomRightResizeGrip >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #initialization }
ToBottomRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement size:
		initialSize + deltaFromInitialPosition
]

{ #category : #initialization }
ToBottomRightResizeGrip >> layoutIn: anElement [

	super layoutIn: anElement.
	self position: anElement size - (thickness @ thickness)
]
