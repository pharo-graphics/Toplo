Class {
	#name : #ToUniversalSelector,
	#superclass : #ToSimpleSelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
