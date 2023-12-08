Class {
	#name : 'ToMinusSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'visiting' }
ToMinusSelector >> accept: aVisitor [

	aVisitor visitMinusSelector: self
]
