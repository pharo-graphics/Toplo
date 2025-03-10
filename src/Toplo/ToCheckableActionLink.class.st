Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> configureToUpdateLinkedObject: anObject from: aCheckable [

	| handler |
	handler := aCheckable
		           addEventHandlerOn: ToCheckableChangedEvent
		           do: [ :event |
			           self
				           launchWithLinkedObject: anObject
				           from: aCheckable
				           onEvent: event
				           withValue: event checked ].
	self addedHandler: handler in: aCheckable
]
