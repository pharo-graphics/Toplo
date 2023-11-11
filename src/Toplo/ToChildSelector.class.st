Class {
	#name : 'ToChildSelector',
	#superclass : 'ToBinarySelector',
	#instVars : [
		'depth'
	],
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'visiting' }
ToChildSelector >> accept: aVisitor [

	aVisitor visitChildSelector: self
]

{ #category : 'accessing' }
ToChildSelector >> depth [

	^ depth
]

{ #category : 'accessing' }
ToChildSelector >> depth: anInteger [

	depth := anInteger
]

{ #category : 'initialization' }
ToChildSelector >> initialize [ 

	super initialize.
	self left: ToUniversalSelector new.
	depth := nil
]
