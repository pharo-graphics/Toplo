Class {
	#name : #ToClickableActionEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'instance creation' }
ToClickableActionEventHandler class >> action: aBlock [

	^ self new action: aBlock
]

{ #category : #'as yet unclassified' }
ToClickableActionEventHandler >> action: aBlock [

	action := aBlock
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> handleEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isDisabled ifTrue: [ ^ self ].
	action ifNil: [ ^ self ].
	action cull: anEvent
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> wantsEvent: anEvent [

	^ (anEvent isKindOf: anEvent currentTarget clickEventClass) 
]
