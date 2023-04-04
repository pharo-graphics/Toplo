Class {
	#name : #ToBottomResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToBottomResizeGrip >> cursorSelector [

	^ #resizeBottom
]

{ #category : #initialization }
ToBottomResizeGrip >> layoutIn: anElement [

	self size: anElement width - (thickness * 2) @ thickness.
	self position: thickness @ (anElement height - (thickness / 2))
]

{ #category : #initialization }
ToBottomResizeGrip >> newPullHandler [

	^ super newPullHandler beVertical.

]

{ #category : #initialization }
ToBottomResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: self initialTargetSize x @ (self initialTargetSize y + anEvent delta y)
]
