Class {
	#name : 'ToOpenedState',
	#superclass : 'ToPersistentState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'sending' }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
