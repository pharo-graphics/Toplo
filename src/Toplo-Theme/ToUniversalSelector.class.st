Class {
	#name : #ToUniversalSelector,
	#superclass : #ToSimpleSelector,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
