Class {
	#name : #ToSiblingSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToSiblingSelector >> accept: aVisitor [

	aVisitor visitSiblingSelector: self
]

{ #category : #converting }
ToSiblingSelector >> asSourceCode [

	^ '(' , self left asSourceCode , ') withSibling: (' , self right asSourceCode
	  , ')'
]

{ #category : #initialization }
ToSiblingSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
]
