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