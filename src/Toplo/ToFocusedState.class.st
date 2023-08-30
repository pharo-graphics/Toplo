Class {
	#name : #ToFocusedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToFocusedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToFocusedLookEvent new
]

{ #category : #testing }
ToFocusedState >> isFocusedState [

	^ true
]
