Class {
	#name : 'ToIndeterminateState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToIndeterminateState >> lookEventClass [

	^ ToIndeterminateLookEvent
]
