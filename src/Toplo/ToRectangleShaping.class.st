Class {
	#name : #ToRectangleShaping,
	#superclass : #ToQuadShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToRectangleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRectangleShaping: self on: anElement ]
]
