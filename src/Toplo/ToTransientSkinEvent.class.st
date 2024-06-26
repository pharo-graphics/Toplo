Class {
	#name : #ToTransientSkinEvent,
	#superclass : #ToSkinEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToTransientSkinEvent class >> isAbstract [

	^ self == ToTransientSkinEvent
]

{ #category : #accessing }
ToTransientSkinEvent class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : #accessing }
ToTransientSkinEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToTransientSkinEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
