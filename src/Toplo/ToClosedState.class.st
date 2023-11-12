Class {
	#name : 'ToClosedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'sending' }
ToClosedState >> lookEventClass [

	^ ToClosedLookEvent
]
