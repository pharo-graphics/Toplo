Class {
	#name : #ToClickableActionEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'instance creation' }
ToClickableActionEventHandler class >> action: aBlock [

	^ self new action: aBlock
]

{ #category : #accessing }
ToClickableActionEventHandler >> action: aBlock [

	action := aBlock
]

{ #category : #'event handling' }
ToClickableActionEventHandler >> clickableRunActionEvent: anEvent [

	anEvent currentTarget clickEvent: anEvent.
	action cull: anEvent
]

{ #category : #'api - accessing' }
ToClickableActionEventHandler >> eventsToHandle [

	^ { ToClickableRunActionEvent }
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> handleEvent: anEvent [

	(anEvent isKindOf: anEvent currentTarget clickEventClass)
		ifTrue: [
			self receiveClickEvent: anEvent.
			^ self ].
	anEvent sendTo: self
]

{ #category : #'event handling' }
ToClickableActionEventHandler >> receiveClickEvent: anEvent [

	| unanimityRequest |
	unanimityRequest := ToClickableActionRequestEvent new sourceEvent:
		                    ToClickableRunActionEvent new.
	anEvent currentTarget fireUnanimityRequest: unanimityRequest
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> wantsEvent: anEvent [

	^ (anEvent isKindOf: anEvent currentTarget clickEventClass) or: [
		  super wantsEvent: anEvent ]
]
