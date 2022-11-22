Class {
	#name : #ToBottomRightResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #initialization }
ToBottomRightResizeGrip >> layoutIn: anElement [

	self relocate: anElement size - (self width / 2 @ (self height / 2)).

]

{ #category : #accessing }
ToBottomRightResizeGrip >> ptName [

	^ #bottomRight
]

{ #category : #initialization }
ToBottomRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: self initialTargetSize + anEvent delta
]
