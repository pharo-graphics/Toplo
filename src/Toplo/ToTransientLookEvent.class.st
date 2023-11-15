Class {
	#name : 'ToTransientLookEvent',
	#superclass : 'ToElementLookEvent',
	#instVars : [
		'sourceEvent'
	],
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'accessing' }
ToTransientLookEvent class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : 'accessing' }
ToTransientLookEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToTransientLookEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
