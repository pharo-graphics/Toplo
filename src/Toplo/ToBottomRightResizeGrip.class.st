Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToBottomRightResizeGrip >> cursorSelector [

	^ #resizeBottomRight
]

{ #category : #initialization }
ToBottomRightResizeGrip >> layoutIn: anElement [

	self relocate: anElement size - (self width / 2 @ (self height / 2)).

]

{ #category : #initialization }
ToBottomRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: self initialTargetSize + anEvent delta
]
