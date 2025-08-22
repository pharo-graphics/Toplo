Class {
	#name : #ToActionLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'action'
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
	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event | self onRunActionRequest: event ].
	self addedHandler: handler in: self
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

	| runnedBlock |
	widget isDisabled ifTrue: [ ^ self ].
	runnedBlock := [
		               | space time evt |
		               action cull: anEvent sourceEvent.
		               space := widget space.
		               time := space ifNotNil: [ :sp | sp time ].
		               evt := ToLinkActionRunnedEvent new
			                      fillFromTime: time;
			                      sourceEvent: anEvent sourceEvent;
			                      yourself.
		               self dispatchEvent: evt copy.
		               widget fireEvent: evt ].
	"runnedBlock value"
	widget space
		ifNil: [ widget inUIProcessDo: runnedBlock ]
		ifNotNil: [ runnedBlock value ]
]

{ #category : #running }
ToActionLink >> run [

	self dispatchEvent: ToRunLinkActionRequest new
]

{ #category : #running }
ToActionLink >> runWithEvent: anEvent [

	self dispatchEvent: (ToRunLinkActionRequest new
			 sourceEvent: anEvent;
			 yourself)
]