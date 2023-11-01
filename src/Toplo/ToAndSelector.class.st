Class {
	#name : #ToAndSelector,
	#superclass : #ToBinarySelector,
	#category : #'Toplo-Core-Selector'
}

{ #category : #visiting }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]

{ #category : #printing }
ToAndSelector >> printOnStyleSheet: aStream [

	self left ifNotNil:[ :e | e printOnStyleSheet: aStream. aStream space ].
	aStream space; nextPutAll: 'AND'; space.
	self right ifNotNil:[ :e | aStream space. e printOnStyleSheet: aStream ].
]
