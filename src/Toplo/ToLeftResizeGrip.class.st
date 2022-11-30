Class {
	#name : #ToLeftResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToLeftResizeGrip >> cursorSelector [

	^ #resizeLeft
]

{ #category : #initialization }
ToLeftResizeGrip >> layoutIn: anElement [

	self relocate: (self width / 2) negated @ self defaultThickness.
	self size: self defaultThickness  @ (anElement height - (self defaultThickness * 2))
]

{ #category : #initialization }
ToLeftResizeGrip >> newPullHandler [

	^ super newPullHandler beHorizontal; relocateX: false; yourself.

]

{ #category : #initialization }
ToLeftResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate:
		self initialTargetPosition x + anEvent delta x @ self initialTargetPosition y.
	anElement size:
		self initialTargetSize x - anEvent delta x @ self initialTargetSize y
]
