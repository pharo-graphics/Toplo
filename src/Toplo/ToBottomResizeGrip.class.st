Class {
	#name : #ToBottomResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToBottomResizeGrip >> cursorSelector [

	^ #resizeBottom
]

{ #category : #initialization }
ToBottomResizeGrip >> layoutIn: anElement [

	self relocate: self defaultThickness @ (anElement height - (self height / 2)).
	self size: anElement width - (self defaultThickness * 2) @ self defaultThickness 
]

{ #category : #initialization }
ToBottomResizeGrip >> newPullHandler [

	^ super newPullHandler beVertical.

]

{ #category : #initialization }
ToBottomResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: self initialTargetSize x @ (self initialTargetSize y + anEvent delta y)
]
