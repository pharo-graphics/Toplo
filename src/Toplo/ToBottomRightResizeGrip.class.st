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
ToBottomRightResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position: anElement size - (thickness / 2 @ (thickness / 2))
]

{ #category : #initialization }
ToBottomRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: self initialTargetSize + anEvent delta
]
