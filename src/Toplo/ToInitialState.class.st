Class {
	#name : 'ToInitialState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'testing' }
ToInitialState >> isPersistent [ 

	^ false
]

{ #category : 'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
