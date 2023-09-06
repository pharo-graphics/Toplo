Class {
	#name : #ToUniversalSelector,
	#superclass : #ToUnarySelector,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
