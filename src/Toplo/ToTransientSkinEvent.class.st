Class {
	#name : #ToTransientSkinEvent,
	#superclass : #ToSkinEvent,
	#traits : 'TToSimpleState',
	#classTraits : 'TToSimpleState classTrait',
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

{ #category : #'t - simple state' }
ToTransientSkinEvent >> skinEvent [ 

	^ self
]

{ #category : #accessing }
ToTransientSkinEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToTransientSkinEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent copy
]
