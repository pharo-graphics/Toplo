Class {
	#name : #ToSelectedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToSelectedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToSelectedLookEvent new
]

{ #category : #testing }
ToSelectedState >> isSelectedState [

	^ true
]
