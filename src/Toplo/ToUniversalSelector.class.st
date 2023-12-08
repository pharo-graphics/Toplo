Class {
	#name : 'ToUniversalSelector',
	#superclass : 'ToSimpleSelector',
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'visiting' }
ToUniversalSelector >> accept: aVisitor [

	aVisitor visitUniversalSelector: self
]
