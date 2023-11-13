Class {
	#name : 'ToInitialState',
	#superclass : 'ToManagementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
