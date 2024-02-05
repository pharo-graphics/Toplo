Class {
	#name : #ToNotSelector,
	#superclass : #ToUnarySelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]

{ #category : #converting }
ToNotSelector >> asSourceCode [

	^ '(' , self left asSourceCode , ') not'
]
