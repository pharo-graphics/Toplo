Class {
	#name : #ToAndSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]
