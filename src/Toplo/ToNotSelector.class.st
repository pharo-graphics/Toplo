Class {
	#name : 'ToNotSelector',
	#superclass : 'ToUnarySelector',
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]

{ #category : 'printing' }
ToNotSelector >> printOnStyleSheet: aStream [

	aStream nextPutAll: 'NOT'.
]
