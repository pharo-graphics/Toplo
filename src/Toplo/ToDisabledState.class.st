Class {
	#name : #ToDisabledState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToDisabledState >> isDisabledState [

	^ true
]

{ #category : #'look event sending' }
ToDisabledState >> sendEvent: anEvent toLook: aLook [

	aLook disabledLookEvent: anEvent
]
