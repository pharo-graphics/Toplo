Class {
	#name : 'ToAndSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'visiting' }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]
