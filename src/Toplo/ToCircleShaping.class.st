Class {
	#name : #ToCircleShaping,
	#superclass : #ToControlShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToCircleShaping >> applyOn: anElement [

	anElement spacingWidth: 0.
	anElement padding: BlInsets empty.
	anElement skinDo: [ :s |
		anElement size: (s sizing heightOn: anElement) asPoint ].
	anElement geometry: BlCircleGeometry new.
	anElement layout: BlFrameLayout new.
]
