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
		           do: [ :event |
			           self
				           launchWithLinkedObject: anObjectOrValuable 
				           from: aCheckable
				           onEvent: event
				           withValue: event checked ].
	self addedHandler: handler in: aCheckable
]
