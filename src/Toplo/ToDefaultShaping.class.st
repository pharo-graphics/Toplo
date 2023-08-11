Class {
	#name : #ToDefaultShaping,
	#superclass : #ToRectShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToDefaultShaping >> applyOn: anElement [

	| radius |
	super applyOn: anElement.
	anElement skinDo: [ :s |
		radius := s sizing shapingRadiusIn: anElement.
		anElement geometry: (BlRoundedRectangleGeometry cornerRadius: radius) ]
]
