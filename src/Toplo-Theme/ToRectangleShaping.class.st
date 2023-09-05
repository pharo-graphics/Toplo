Class {
	#name : #ToRectangleShaping,
	#superclass : #ToQuadShaping,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #hook }
ToRectangleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRectangleShaping: self on: anElement ]
]
