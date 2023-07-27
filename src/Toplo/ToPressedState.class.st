Class {
	#name : #ToPressedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToPressedState >> isPressedState [

	^ true
]

{ #category : #'look event sending' }
ToPressedState >> sendEvent: anEvent toLook: aLook [

	aLook pressedLookEvent: anEvent
]
