Class {
	#name : #ToCircleShaping,
	#superclass : #ToControlShaping,
	#category : 'Toplo-Theme-Skin-dep'
}

{ #category : #hook }
ToCircleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyCircleShaping: self on: anElement ]
]
