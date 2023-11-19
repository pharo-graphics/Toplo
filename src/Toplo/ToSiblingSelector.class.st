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
