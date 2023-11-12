Class {
	#name : 'ToInitialState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
