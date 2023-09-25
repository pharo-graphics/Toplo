Class {
	#name : #ToNotSelector,
	#superclass : #ToUnarySelector,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]
