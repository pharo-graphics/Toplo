Class {
	#name : 'ToIntrinsicState',
	#superclass : 'ToImplicitState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToIntrinsicState >> enqueuedFor: anElement [

	super enqueuedFor: anElement.
	anElement skinManager intrinicState: self enqueuedFor: anElement
]
