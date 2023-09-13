Class {
	#name : #ToOrSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]
