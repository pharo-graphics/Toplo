Class {
	#name : #ToSiblingSelector,
	#superclass : #ToBinarySelector,
	#category : 'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToSiblingSelector >> accept: aVisitor [

	aVisitor visitSiblingSelector: self
]

{ #category : #initialization }
ToSiblingSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
]
