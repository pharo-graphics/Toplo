Class {
	#name : 'ToSiblingSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToSiblingSelector >> accept: aVisitor [

	aVisitor visitSiblingSelector: self
]

{ #category : 'initialization' }
ToSiblingSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
]

{ #category : 'printing' }
ToSiblingSelector >> printOnStyleSheet: aStream [

	self left ifNotNil:[ :e | e printOnStyleSheet: aStream. aStream space ].
	aStream space; nextPutAll: '[SIBLING]'; space.
	self right ifNotNil:[ :e | aStream space. e printOnStyleSheet: aStream ].
]
