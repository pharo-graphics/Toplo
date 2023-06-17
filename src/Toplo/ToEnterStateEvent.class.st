Class {
	#name : #ToEnterStateEvent,
	#superclass : #ToStateEvent,
	#instVars : [
		'previousState'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToEnterStateEvent >> previousState [

	^ previousState
]

{ #category : #accessing }
ToEnterStateEvent >> previousState: aState [

	previousState := aState
]
