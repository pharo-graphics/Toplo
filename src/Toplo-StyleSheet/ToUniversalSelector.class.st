Class {
	#name : #ToUniversalSelector,
	#superclass : #ToElementSelector,
	#category : #'Toplo-StyleSheet'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
