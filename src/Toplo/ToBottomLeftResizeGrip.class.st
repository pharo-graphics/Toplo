Class {
	#name : #ToBottomLeftResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Root frame'
}

{ #category : #initialization }
ToBottomLeftResizeGrip >> layoutIn: anElement [

	self relocate: 0 @ anElement height - (self width / 2 @ (self height / 2)) 
]

{ #category : #accessing }
ToBottomLeftResizeGrip >> ptName [

	^ #bottomLeft
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> pullEvent: anEvent on: anElement [

		anElement relocate: self initialTargetPosition x + anEvent delta x @ self initialTargetPosition y.
		anElement size: self initialTargetSize x - anEvent delta x @ (self initialTargetSize y + anEvent delta y)
]
