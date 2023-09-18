Class {
	#name : #ToOrSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]
