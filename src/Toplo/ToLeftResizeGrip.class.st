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

	self size: thickness @ (anElement height - (thickness * 2)).
	self position: (thickness / 2) negated @ thickness
]

{ #category : #initialization }
ToLeftResizeGrip >> newPullHandler [

	^ super newPullHandler beHorizontal; relocateX: false; yourself.

]

{ #category : #initialization }
ToLeftResizeGrip >> pullEvent: anEvent on: anElement [

	anElement position: self initialTargetPosition x + anEvent delta x
		@ self initialTargetPosition y.
	anElement size:
		self initialTargetSize x - anEvent delta x
		@ self initialTargetSize y
]
