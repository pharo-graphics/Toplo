Class {
	#name : #ToFocusedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToFocusedState >> isFocusedState [

	^ true
]

{ #category : #'look event sending' }
ToFocusedState >> sendEvent: anEvent toLook: aLook [ 

	aLook focusedLookEvent: anEvent
]
