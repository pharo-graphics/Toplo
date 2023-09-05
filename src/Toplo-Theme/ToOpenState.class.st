Class {
	#name : #ToOpenState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #sending }
ToOpenState >> applyOn: anElement [

	anElement dispatchLookEvent: ToOpenLookEvent new
]

{ #category : #testing }
ToOpenState >> isOpenState [

	^ true
]
