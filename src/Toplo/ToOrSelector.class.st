Class {
	#name : #ToOrSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]
