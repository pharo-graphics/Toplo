Class {
	#name : #ToFocusedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToFocusedState >> sendEvent: anEvent toLook: aLook [ 

	aLook focusedLookEvent: anEvent
]
