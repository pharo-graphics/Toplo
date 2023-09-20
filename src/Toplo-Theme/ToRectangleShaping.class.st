Class {
	#name : 'ToRectangleShaping',
	#superclass : 'ToQuadShaping',
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'hook' }
ToRectangleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRectangleShaping: self on: anElement ]
]
