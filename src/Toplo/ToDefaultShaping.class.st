Class {
	#name : #ToDefaultShaping,
	#superclass : #ToRectShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToDefaultShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyDefaultShaping: self on: anElement ]
]
