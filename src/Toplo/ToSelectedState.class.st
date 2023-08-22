Class {
	#name : #ToSelectedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToSelectedState >> isSelectedState [

	^ true
]

{ #category : #'look event sending' }
ToSelectedState >> sendEvent: anEvent toLook: aLook [

	aLook selectedLookEvent: anEvent
]
