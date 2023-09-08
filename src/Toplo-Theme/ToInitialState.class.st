Class {
	#name : #ToInitialState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToInitialState >> applyOn: anElement [

	anElement dispatchLookEvent: ToInitialLookEvent new
]
