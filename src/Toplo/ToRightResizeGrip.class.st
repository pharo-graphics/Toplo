Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #initialization }
ToRightResizeGrip >> layoutIn: anElement [

	self relocate: anElement size x - (self width / 2) @ 10.
	self size: 3 @ (anElement height - 20)
]

{ #category : #initialization }
ToRightResizeGrip >> newPullHandler [

	^ super newPullHandler beHorizontal 

]

{ #category : #accessing }
ToRightResizeGrip >> ptName [

	^ #right
]

{ #category : #initialization }
ToRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement size: (self initialTargetSize x + anEvent delta x) @ (self initialTargetSize y )
]
