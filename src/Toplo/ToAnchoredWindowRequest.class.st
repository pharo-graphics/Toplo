Class {
	#name : #ToAnchoredWindowRequest,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowRequest >> sendTo: anObject [

	anObject anchoredWindowRequest: self
]

{ #category : #accessing }
ToAnchoredWindowRequest >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToAnchoredWindowRequest >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
