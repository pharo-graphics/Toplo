Class {
	#name : #ToUncheckedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToUncheckedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToUncheckedLookEvent new
]
