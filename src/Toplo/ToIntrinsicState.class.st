Class {
	#name : 'ToIntrinsicState',
	#superclass : 'ToImplicitState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToIntrinsicState >> onEnqueuedFor: anElement [

	super onEnqueuedFor: anElement.
	anElement skinManager intrinicState: self enqueuedFor: anElement
]
