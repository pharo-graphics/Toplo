Class {
	#name : #ToChildSelector,
	#superclass : #ToBinarySelector,
	#instVars : [
		'depth'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToChildSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self depth = anObject depth
]

{ #category : #visiting }
ToChildSelector >> accept: aVisitor [

	aVisitor visitChildSelector: self
]

{ #category : #converting }
ToChildSelector >> asSourceCode [

	(self depth isNil or: [ self depth = 1 ]) ifTrue: [
		^ '(' , self left asSourceCode , ') withChild: ('
		  , self right asSourceCode , ')' ].
	^ '(' , self left asSourceCode , ') withChild: ('
	  , self right asSourceCode , ') atDepth:' , self depth printString
]

{ #category : #accessing }
ToChildSelector >> depth [
	"evaluate only for children at a given depth or at any depth if selector depth is not specified "

	^ depth
]

{ #category : #accessing }
ToChildSelector >> depth: anInteger [
	"evaluate only for children at a given depth or at any depth if selector depth is not specified "

	depth := anInteger
]

{ #category : #initialization }
ToChildSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
	depth := nil
]
