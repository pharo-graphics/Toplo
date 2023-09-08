Class {
	#name : #ToDisabledState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToDisabledState >> applyOn: anElement [

	anElement dispatchLookEvent: ToDisabledLookEvent new
]
