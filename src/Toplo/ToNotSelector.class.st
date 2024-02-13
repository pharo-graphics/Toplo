Class {
	#name : #ToNotSelector,
	#superclass : #ToUnarySelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]
