Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Root frame'
}

{ #category : #initialization }
ToTopRightResizeGrip >> layoutIn: anElement [

	self relocate: (anElement size x - (self width / 2)) @ ((self height / 2) negated)



]

{ #category : #accessing }
ToTopRightResizeGrip >> ptName [

	^ #topRight
]

{ #category : #initialization }
ToTopRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate: self initialTargetPosition x  @ (self initialTargetPosition y + anEvent delta y).
	anElement size: (self initialTargetSize x + anEvent delta x) @ (self initialTargetSize y - anEvent delta y)
]
