Class {
	#name : #ToUniversalSelector,
	#superclass : #ToSimpleSelector,
	#category : #'Toplo-Core-Selector'
}

{ #category : #visiting }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]

{ #category : #printing }
ToUniversalSelector >> printOnStyleSheet: aStream [

	aStream nextPutAll: '*'.
]
