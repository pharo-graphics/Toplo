Class {
	#name : #ToInitialState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #testing }
ToInitialState >> isPersistent [ 

	^ false
]

{ #category : #'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
