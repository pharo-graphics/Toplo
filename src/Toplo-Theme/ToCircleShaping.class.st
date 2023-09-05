Class {
	#name : #ToCircleShaping,
	#superclass : #ToControlShaping,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #hook }
ToCircleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyCircleShaping: self on: anElement ]
]
