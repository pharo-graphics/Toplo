Class {
	#name : #ToUniversalSelector,
	#superclass : #ToSimpleSelector,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
