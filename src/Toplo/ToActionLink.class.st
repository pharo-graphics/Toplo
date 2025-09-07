Class {
	#name : #ToActionLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'action',
		'runCount'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToActionLink >> action: anAction [

	action := anAction
]

{ #category : #initialization }
ToActionLink >> linkWith: anElement [

	| handler |
	super linkWith: anElement.
	runCount := 0.
	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event | self onRunActionRequest: event ].
	self addedHandler: handler in: self.
	anElement registerAction: self
]

{ #category : #running }
ToActionLink >> onActionRunnedDo: aValuable [

	self
		addedHandler: (self
				 addEventHandlerOn: ToLinkActionRunnedEvent
				 do: [ :evt | aValuable cull: evt sourceEvent ])
		in: self
]

{ #category : #running }
ToActionLink >> onRunActionRequest: anEvent [

	widget isDisabled ifTrue: [ ^ self ].
	widget isAttachedToSceneGraph
		ifTrue: [ self onRunnedOnRequest: anEvent ]
		ifFalse: [
		widget inUIProcessDo: [ self onRunnedOnRequest: anEvent ] ]
]

{ #category : #running }
ToActionLink >> onRunnedOnRequest: anEvent [

	| space time evt |
	action cull: anEvent sourceEvent.
	space := widget space.
	time := space ifNotNil: [ :sp | sp time ].
	evt := ToLinkActionRunnedEvent new
		       fillFromTime: time;
		       sourceEvent: anEvent sourceEvent;
		       yourself.
	self dispatchEvent: evt copy.
	widget fireEvent: evt.
	runCount := runCount + 1
]

{ #category : #running }
ToActionLink >> run [

	self dispatchEvent: ToRunLinkActionRequest new
]

{ #category : #accessing }
ToActionLink >> runCount [ 

	^ runCount
]

{ #category : #running }
ToActionLink >> runWithEvent: anEvent [

	self dispatchEvent: (ToRunLinkActionRequest new
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #initialization }
ToActionLink >> unlink [

	widget unregisterAction: self.
	super unlink
]
