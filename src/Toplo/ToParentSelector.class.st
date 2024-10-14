Class {
	#name : #ToParentSelector,
	#superclass : #ToBinarySelector,
	#instVars : [
		'depth'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #comparing }
ToParentSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self depth = anObject depth
]

{ #category : #visiting }
ToParentSelector >> accept: aVisitor [

	aVisitor visitParentSelector: self
]

{ #category : #'as yet unclassified' }
ToParentSelector >> depth [
	"evaluate only for parent at a given depth or at any depth if selector depth is not specified "

	^ depth
]

{ #category : #'as yet unclassified' }
ToParentSelector >> depth: anInteger [
	"evaluate only for parent at a given depth or at any depth if selector depth is not specified "

	depth := anInteger
]

{ #category : #comparing }
ToParentSelector >> hash [

	^ super hash bitXor: depth hash
]

{ #category : #initialization }
ToParentSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new
]
