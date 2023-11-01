Class {
	#name : 'ToOrSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToOrSelector >> accept: aVisitor [

	aVisitor visitOrSelector: self
]

{ #category : 'printing' }
ToOrSelector >> printOnStyleSheet: aStream [

	self left ifNotNil:[ :e | e printOnStyleSheet: aStream. aStream space ].
	aStream nextPutAll: ','; space.
	self right ifNotNil:[ :e | aStream space. e printOnStyleSheet: aStream ].
]
