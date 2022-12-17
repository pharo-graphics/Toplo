Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToRightResizeGrip >> cursorSelector [

	^ #resizeRight
]

{ #category : #initialization }
ToRightResizeGrip >> layoutIn: anElement [

	self size: thickness  @ (anElement height - (thickness * 2)).
	self relocate: anElement width - (thickness / 2) @ thickness.

]

{ #category : #initialization }
ToRightResizeGrip >> newPullHandler [

	^ super newPullHandler beHorizontal 

]

{ #category : #initialization }
ToRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: (self initialTargetSize x + anEvent delta x) @ (self initialTargetSize y )
]
