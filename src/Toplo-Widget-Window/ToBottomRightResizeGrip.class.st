Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToBottomRightResizeGrip >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #initialization }
ToBottomRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement size:
		initialTargetSize + deltaFromInitialPosition
]

{ #category : #initialization }
ToBottomRightResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position: anElement size - (thickness / 2 @ (thickness / 2))
]
