Class {
	#name : #ToInitialState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToInitialState >> isInitialState [

	^ true
]

{ #category : #'look event sending' }
ToInitialState >> sendEvent: anEvent toLook: aLook [

	aLook initialLookEvent: anEvent
]
