Class {
	#name : 'ToOpenedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'sending' }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
