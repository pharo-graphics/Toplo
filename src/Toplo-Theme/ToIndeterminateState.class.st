Class {
	#name : #ToIndeterminateState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToIndeterminateState >> applyOn: anElement [

	anElement dispatchLookEvent: ToIndeterminateLookEvent new
]
