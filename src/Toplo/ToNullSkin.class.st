Class {
	#name : #ToNullSkin,
	#superclass : #ToSkin,
	#classVars : [
		'Instance'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #accessing }
ToNullSkin class >> instance [ 

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #'state  application dispatch' }
ToNullSkin >> applyEnqueuedStatesFor: anElement [
	" run the skin actually by flushing the state queue"

	anElement skinManagerDo: [ :sm | sm skinStateQueue resetStates ]
]

{ #category : #'api - accessing' }
ToNullSkin >> eventsToHandle [

	^ {  }
]

{ #category : #'api - event managing' }
ToNullSkin >> handleEvent: anEvent [
]

{ #category : #testing }
ToNullSkin >> isNullSkin [ 

	^ true
]
