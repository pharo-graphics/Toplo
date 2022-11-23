Class {
	#name : #ToLeftResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToLeftResizeGrip >> cursorSelector [

	^ #resizeLeft
]

{ #category : #initialization }
ToLeftResizeGrip >> layoutIn: anElement [

	self relocate: (self width / 2) negated @ 10.
	self size: 3 @ (anElement height - 20)
]

{ #category : #initialization }
ToLeftResizeGrip >> newPullHandler [

	^ super newPullHandler beHorizontal.

]

{ #category : #initialization }
ToLeftResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate:
		self initialTargetPosition x + anEvent delta x @ self initialTargetPosition y.
	anElement size:
		self initialTargetSize x - anEvent delta x @ self initialTargetSize y
]
