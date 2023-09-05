Class {
	#name : #ToUniversalSelector,
	#superclass : #ToElementSelector,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
