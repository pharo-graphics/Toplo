Class {
	#name : #ToClosedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #sending }
ToClosedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToClosedLookEvent new
]
