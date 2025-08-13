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

	self addedHandler:
		(self addEventHandlerOn: ToLinkActionRunnedEvent do: [ :evt |
			 aValuable
				 cull: evt sourceEvent
				 cull: evt linkedObject
				 cull: evt changedValue ])
]

{ #category : #running }
ToActionLink >> onRunLinkActionRequest: anEvent onWidget: aTarget withValue: aValue [

	| runnedBlock |
	aTarget isDisabled ifTrue: [ ^ self ].
	runnedBlock := [
		               | space time evt |
		               action
			               cull: anEvent sourceEvent
			               cull: aValue.
		               space := aTarget space.
		               time := space ifNotNil: [ :sp | sp time ].
		               evt := ToLinkActionRunnedEvent new
			                      fillFromTime: time;
			                      sourceEvent: anEvent sourceEvent;
			                      changedValue: aValue;
			                      yourself.
		               self dispatchEvent: evt.
		               aTarget fireEvent: evt copy ].
	aTarget space
		ifNil: [ aTarget inUIProcessDo: runnedBlock ]
		ifNotNil: [ runnedBlock value ]
]

{ #category : #running }
ToActionLink >> onRunLinkActionRequest: anEvent withLinkedObject: anObjectOrValuable fromWidget: aTarget withValue: aValue [

	| runnedBlock linked |
	aTarget isDisabled ifTrue: [ ^ self ].
	linked := anObjectOrValuable isBlock
		          ifTrue: [ anObjectOrValuable cull: aTarget ]
		          ifFalse: [ anObjectOrValuable ].
	runnedBlock := [
		               | space time evt |
		               action
			               cull: anEvent sourceEvent
			               cull: linked
			               cull: aValue.
		               space := aTarget space.
		               time := space ifNotNil: [ :sp | sp time ].
		               evt := ToLinkActionRunnedEvent new
			                      fillFromTime: time;
			                      linkedObject: anObjectOrValuable;
			                      sourceEvent: anEvent sourceEvent;
			                      changedValue: aValue;
			                      yourself.
		               self dispatchEvent: evt.
		               aTarget fireEvent: evt copy ].
	aTarget space
		ifNil: [ aTarget inUIProcessDo: runnedBlock ]
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
