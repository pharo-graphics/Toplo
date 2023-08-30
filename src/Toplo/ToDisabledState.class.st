Class {
	#name : #ToDisabledState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToDisabledState >> applyOn: anElement [

	anElement dispatchLookEvent: ToDisabledLookEvent new
]

{ #category : #testing }
ToDisabledState >> isDisabledState [

	^ true
]
