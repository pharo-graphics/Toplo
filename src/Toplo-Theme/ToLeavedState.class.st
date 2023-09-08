Class {
	#name : #ToLeavedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToLeavedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToLeavedLookEvent new
]
