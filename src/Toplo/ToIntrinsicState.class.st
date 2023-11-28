Class {
	#name : 'ToIntrinsicState',
	#superclass : 'ToImplicitState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToIntrinsicState >> onEnqueueRequestFor: anElement inQueue: aStateQueue [

	super onEnqueueRequestFor: anElement inQueue: aStateQueue.
	aStateQueue onIntrinsicStateEnqueueRequested: self
]
