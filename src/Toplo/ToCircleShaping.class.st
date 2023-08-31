Class {
	#name : #ToCircleShaping,
	#superclass : #ToControlShaping,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #hook }
ToCircleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyCircleShaping: self on: anElement ]
]
