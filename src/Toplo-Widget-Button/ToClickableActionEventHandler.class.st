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

{ #category : #accessing }
ToClickableActionEventHandler >> action: aBlock [

	action := aBlock
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> handleEvent: anEvent [

	| target |
	anEvent consume.
	target := anEvent currentTarget.
	target isDisabled ifTrue: [ ^ self ].
	action ifNil: [ ^ self ].
	action cull: anEvent.
	" Since the event is consumed, fire an action performed event to let the button or a parent element react "
	target isAttachedToSceneGraph ifFalse: [ ^ self ].
	target fireEvent: (ToClickableActionPerformedEvent new
			 fillFromTime: target space time;
			 yourself)
]

{ #category : #'api - event managing' }
ToClickableActionEventHandler >> wantsEvent: anEvent [

	^ (anEvent isKindOf: anEvent currentTarget clickEventClass) 
]
