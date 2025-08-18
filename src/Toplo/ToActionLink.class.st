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

{ #category : #running }
ToActionLink >> onActionRunnedDo: aValuable [

	self addedHandler: (self
			 addEventHandlerOn: ToLinkActionRunnedEvent
			 do: [ :evt | aValuable cull: evt sourceEvent ])
]

{ #category : #running }
ToActionLink >> onRunLinkActionRequest: anEvent onWidget: aTarget [

	| runnedBlock |
	aTarget isDisabled ifTrue: [ ^ self ].
	runnedBlock := [
		               | space time evt |
		               action cull: anEvent sourceEvent.
		               space := aTarget space.
		               time := space ifNotNil: [ :sp | sp time ].
		               evt := ToLinkActionRunnedEvent new
			                      fillFromTime: time;
			                      sourceEvent: anEvent sourceEvent;
			                      yourself.
		               self dispatchEvent: evt.
		               aTarget fireEvent: evt copy ].
	aTarget space
		ifNil: [ aTarget inUIProcessDo: runnedBlock ]
		ifNotNil: [ runnedBlock value ]
]

{ #category : #initialization }
ToActionLink >> onWidget: aCheckable [

	^ self subclassResponsibility
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
