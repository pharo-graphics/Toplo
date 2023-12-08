Class {
	#name : 'ToNotSelector',
	#superclass : 'ToUnarySelector',
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'visiting' }
ToNotSelector >> accept: aVisitor [

	aVisitor visitNotSelector: self
]
