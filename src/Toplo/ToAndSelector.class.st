Class {
	#name : #ToAndSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]
