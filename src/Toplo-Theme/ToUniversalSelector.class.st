Class {
	#name : #ToUniversalSelector,
	#superclass : #ToSimpleSelector,
	#category : #'Toplo-Theme-StyleOperator'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
