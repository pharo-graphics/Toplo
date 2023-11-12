Class {
	#name : 'ToFocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
