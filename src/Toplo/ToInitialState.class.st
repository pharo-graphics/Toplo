Class {
	#name : #ToInitialState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToInitialState >> applyOn: anElement [

	anElement dispatchLookEvent: ToInitialLookEvent new
]

{ #category : #testing }
ToInitialState >> isInitialState [

	^ true
]
