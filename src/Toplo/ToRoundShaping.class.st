Class {
	#name : #ToRoundShaping,
	#superclass : #ToRectShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToRoundShaping >> applyOn: anElement [

	| radius |
	super applyOn: anElement.
	radius := anElement requestedHeight / 2.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius)
]
