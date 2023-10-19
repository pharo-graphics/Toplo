Class {
	#name : #ToParentSelector,
	#superclass : #ToBinarySelector,
	#instVars : [
		'depth'
	],
	#category : 'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToParentSelector >> accept: aVisitor [

	aVisitor visitParentSelector: self
]

{ #category : #accessing }
ToParentSelector >> depth [

	^ depth
]

{ #category : #accessing }
ToParentSelector >> depth: anInteger [

	depth := anInteger
]

{ #category : #initialization }
ToParentSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
	depth := 1 
]
