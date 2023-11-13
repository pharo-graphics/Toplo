Class {
	#name : 'ToClosedState',
	#superclass : 'ToPersistentState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'sending' }
ToClosedState >> lookEventClass [

	^ ToClosedLookEvent
]
