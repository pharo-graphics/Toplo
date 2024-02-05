Class {
	#name : #ToTransientLookEvent,
	#superclass : #ToElementLookEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #testing }
ToTransientLookEvent class >> isAbstract [

	^ self class == ToTransientLookEvent
]

{ #category : #accessing }
ToTransientLookEvent class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : #accessing }
ToTransientLookEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToTransientLookEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
