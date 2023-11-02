Class {
	#name : 'ToElementLookEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'sourceEvent'
	],
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'accessing' }
ToElementLookEvent class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : 'accessing' }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : 'sending' }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : 'accessing' }
ToElementLookEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToElementLookEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
