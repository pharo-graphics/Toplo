Class {
	#name : #ToBottomResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToBottomResizeGrip >> cursorSelector [

	^ #resizeBottom
]

{ #category : #initialization }
ToBottomResizeGrip >> layoutIn: anElement [

	self relocate: 10 @ (anElement height - (self height / 2)).
	self size: anElement width - 20 @ 3
]

{ #category : #initialization }
ToBottomResizeGrip >> newPullHandler [

	^ super newPullHandler beVertical.

]

{ #category : #initialization }
ToBottomResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: self initialTargetSize x @ (self initialTargetSize y + anEvent delta y)
]
