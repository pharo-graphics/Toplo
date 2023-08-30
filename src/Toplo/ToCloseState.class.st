Class {
	#name : #ToCloseState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #sending }
ToCloseState >> applyOn: anElement [

	anElement dispatchLookEvent: ToCloseLookEvent new
]

{ #category : #testing }
ToCloseState >> isCloseState [

	^ true
]
