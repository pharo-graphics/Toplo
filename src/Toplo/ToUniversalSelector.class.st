Class {
	#name : #ToUniversalSelector,
	#superclass : #ToSimpleSelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]

{ #category : #converting }
ToUniversalSelector >> asSourceCode [

	^ self class name , ' new'
]
