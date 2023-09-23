Class {
	#name : #ToNotSelector,
	#superclass : #ToUnarySelector,
	#category : #'Toplo-Theme-StyleOperator'
}

{ #category : #visiting }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]
