Class {
	#name : #ToPressedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToPressedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToPressedLookEvent new
]

{ #category : #testing }
ToPressedState >> isPressedState [

	^ true
]
