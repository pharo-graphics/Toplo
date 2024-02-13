Class {
	#name : #ToIntrinsicState,
	#superclass : #ToImplicitState,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToIntrinsicState >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	super requestEnqueueFromElement: anElement inQueue: aStateQueue.
	aStateQueue onIntrinsicStateEnqueueRequested: self
]
