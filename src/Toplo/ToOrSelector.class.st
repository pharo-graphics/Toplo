Class {
	#name : #ToOrSelector,
	#superclass : #ToBinarySelector,
	#category : 'Toplo-Core-Selector'
}

{ #category : #visiting }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]
