Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToRightResizeGrip >> cursorSelector [

	^ #resizeRight
]

{ #category : #initialization }
ToRightResizeGrip >> layoutIn: anElement [

	self relocate: anElement size x - (self width / 2) @ self defaultThickness.
	self size: self defaultThickness  @ (anElement height - (self defaultThickness * 2))
]

{ #category : #initialization }
ToRightResizeGrip >> newPullHandler [

	^ super newPullHandler beHorizontal 

]

{ #category : #initialization }
ToRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: (self initialTargetSize x + anEvent delta x) @ (self initialTargetSize y )
]
