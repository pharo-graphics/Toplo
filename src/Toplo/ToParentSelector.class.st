Class {
	#name : #ToParentSelector,
	#superclass : #ToBinarySelector,
	#instVars : [
		'depth'
	],
	#category : #'Toplo-Core-Selector'
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

{ #category : #printing }
ToParentSelector >> printOnStyleSheet: aStream [

	self left ifNotNil:[ :e | e printOnStyleSheet: aStream ].
	aStream space.
	self right ifNotNil:[ :e | e printOnStyleSheet: aStream ].
]
