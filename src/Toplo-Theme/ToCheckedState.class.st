Class {
	#name : #ToCheckedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToCheckedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToCheckedLookEvent new
]
