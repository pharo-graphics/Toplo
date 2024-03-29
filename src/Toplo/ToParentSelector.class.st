Class {
	#name : #ToParentSelector,
	#superclass : #ToBinarySelector,
	#instVars : [
		'depth'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToParentSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self depth = anObject depth
]

{ #category : #visiting }
ToParentSelector >> accept: aVisitor [

	aVisitor visitParentSelector: self
]

{ #category : #accessing }
ToParentSelector >> depth [
	"evaluate only for parent at a given depth or at any depth if selector depth is not specified "

	^ depth
]

{ #category : #accessing }
ToParentSelector >> depth: anInteger [
	"evaluate only for parent at a given depth or at any depth if selector depth is not specified "

	depth := anInteger
]

{ #category : #initialization }
ToParentSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new
]
