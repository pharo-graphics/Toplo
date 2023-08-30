Class {
	#name : #ToOpenState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #sending }
ToOpenState >> applyOn: anElement [

	anElement dispatchLookEvent: ToOpenLookEvent new
]

{ #category : #testing }
ToOpenState >> isOpenState [

	^ true
]
