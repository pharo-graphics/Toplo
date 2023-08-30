Class {
	#name : #ToSelectedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToSelectedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToSelectedLookEvent new
]

{ #category : #testing }
ToSelectedState >> isSelectedState [

	^ true
]
