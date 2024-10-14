Class {
	#name : #ToNoneSelector,
	#superclass : #ToUnarySelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToNoneSelector >> accept: aVisitor [

	aVisitor visitNoneSelector: self
]
