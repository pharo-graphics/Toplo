Class {
	#name : #ToCloseState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #sending }
ToCloseState >> applyOn: anElement [

	anElement dispatchLookEvent: ToCloseLookEvent new
]

{ #category : #testing }
ToCloseState >> isCloseState [

	^ true
]
