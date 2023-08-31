Class {
	#name : #ToRectangleShaping,
	#superclass : #ToQuadShaping,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #hook }
ToRectangleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRectangleShaping: self on: anElement ]
]
