Class {
	#name : #ToOrSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Theme-StyleOperator'
}

{ #category : #visiting }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]
