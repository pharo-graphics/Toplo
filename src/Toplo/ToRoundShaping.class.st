Class {
	#name : #ToRoundShaping,
	#superclass : #ToQuadShaping,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #hook }
ToRoundShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRoundShaping: self on: anElement ]
]
