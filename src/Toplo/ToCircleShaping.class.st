Class {
	#name : #ToCircleShaping,
	#superclass : #ToControlShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToCircleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyCircleShapingOn: anElement ]
]
