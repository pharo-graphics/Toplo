Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #initialization }
ToTopResizeGrip >> layoutIn: anElement [

	self relocate: 10 @ (self height / 2) negated.
	self size: anElement width - 20 @ 3
]

{ #category : #initialization }
ToTopResizeGrip >> newPullHandler [

	^ super newPullHandler beVertical.

]

{ #category : #accessing }
ToTopResizeGrip >> ptName [

	^ #top
]

{ #category : #initialization }
ToTopResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate: (self initialTargetPosition x ) @ (self initialTargetPosition y + anEvent delta y).
	anElement size: (self initialTargetSize x ) @ (self initialTargetSize y - anEvent delta y)
]
