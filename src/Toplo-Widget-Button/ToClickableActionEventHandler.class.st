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

{ #category : #'as yet unclassified' }
ToClickableActionEventHandler >> action: aBlock [

	action := aBlock
]

{ #category : #'as yet unclassified' }
ToClickableActionEventHandler >> clickableRunActionEvent: anEvent [

	anEvent currentTarget clickEvent: anEvent.
	action cull: anEvent
]

{ #category : #'as yet unclassified' }
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

	| req target |
	target := anEvent currentTarget.
	req := ToClickableActionRequestEvent new
		       requestedAction: [
			       target fireEvent: (ToClickableRunActionEvent new
						        sourceEvent: anEvent;
						        yourself) ];
		       yourself.
	target fireAuthorisationRequest: req
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> wantsEvent: anEvent [

	^ (anEvent isKindOf: anEvent currentTarget clickEventClass) or: [
		  super wantsEvent: anEvent ]
]
