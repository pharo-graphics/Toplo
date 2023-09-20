Class {
	#name : 'ToCircleShaping',
	#superclass : 'ToControlShaping',
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'hook' }
ToCircleShaping >> applyOn: anElement [

	anElement skinDo: [ :s | s applyCircleShaping: self on: anElement ]
]
