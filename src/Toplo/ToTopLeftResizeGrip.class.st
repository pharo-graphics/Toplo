Class {
	#name : #ToTopLeftResizeGrip,
	#superclass : #ToResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToTopLeftResizeGrip >> cursorSelector [

	^ #resizeTopLeft
]

{ #category : #initialization }
ToTopLeftResizeGrip >> layoutIn: anElement [

	self relocate: ((self width / 2 @ (self height / 2)) negated)
	



]

{ #category : #initialization }
ToTopLeftResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate: (self initialTargetPosition x + anEvent delta x) @ (self initialTargetPosition y + anEvent delta y).
	anElement size: (self initialTargetSize x - anEvent delta x) @ (self initialTargetSize y - anEvent delta y)
]
