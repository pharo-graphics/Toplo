Class {
	#name : 'ToRoundShaping',
	#superclass : 'ToQuadShaping',
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'hook' }
ToRoundShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyRoundShaping: self on: anElement ]
]
