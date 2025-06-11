Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> configureToUpdateLinkedObject: anObjectOrValuable from: aCheckable [

	| handler |
	
	handler := aCheckable
		           addEventHandlerOn: ToCheckableChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: aCheckable.
	
	handler := self
		           addEventHandlerOn: ToRunLinkActionEvent
		           do: [ :event |
			           self
				           launchWithLinkedObject: anObjectOrValuable 
				           from: aCheckable
				           onEvent: event sourceEvent
				           withValue: aCheckable checked ].
	self addedHandler: handler in: self
]
