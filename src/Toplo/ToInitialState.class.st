Class {
	#name : #ToInitialState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #testing }
ToInitialState >> isPersistent [ 

	^ false
]

{ #category : #'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
