Class {
	#name : #ToEnterStateEvent,
	#superclass : #ToStateEvent,
	#instVars : [
		'previousState'
	],
	#category : #'Toplo-Core'
}

{ #category : #testing }
ToEnterStateEvent class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
ToEnterStateEvent >> previousState [

	^ previousState
]

{ #category : #accessing }
ToEnterStateEvent >> previousState: aState [

	previousState := aState
]
