Class {
	#name : 'ToInitialState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'testing' }
ToInitialState >> isPersistent [ 

	^ false
]

{ #category : 'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
