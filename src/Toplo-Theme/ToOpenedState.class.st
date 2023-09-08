Class {
	#name : #ToOpenedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #sending }
ToOpenedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToOpenedLookEvent new
]
