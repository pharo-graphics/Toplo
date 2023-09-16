Class {
	#name : #ToRoundShaping,
	#superclass : #ToQuadShaping,
	#category : #'Toplo-Theme-Skin-dep'
}

{ #category : #hook }
ToRoundShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRoundShaping: self on: anElement ]
]
