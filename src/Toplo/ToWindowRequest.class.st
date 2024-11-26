Class {
	#name : #ToWindowRequest,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowRequest >> sendTo: anObject [

	anObject windowRequest: self
]

{ #category : #sending }
ToWindowRequest >> sendToWindowManager: anObject [

	anObject windowRequest: self
]

{ #category : #accessing }
ToWindowRequest >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToWindowRequest >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
