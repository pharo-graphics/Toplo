Class {
	#name : #ToPressedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToPressedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToPressedLookEvent new
]

{ #category : #testing }
ToPressedState >> isPressedState [

	^ true
]
