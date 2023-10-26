Class {
	#name : 'ToAndSelector',
	#superclass : 'ToBinarySelector',
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToAndSelector >> accept: aVisitor [

	aVisitor visitAndSelector: self
]
