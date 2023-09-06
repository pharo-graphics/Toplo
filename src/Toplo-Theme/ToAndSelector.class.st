Class {
	#name : #ToAndSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]
