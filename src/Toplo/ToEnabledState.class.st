Class {
	#name : #ToEnabledState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToEnabledState >> isEnabledState [

	^ true
]

{ #category : #'look event sending' }
ToEnabledState >> sendEvent: anEvent toLook: aLook [

	aLook enabledLookEvent: anEvent
]
