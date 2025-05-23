Class {
	#name : #ToCheckableLink,
	#superclass : #ToPropertyLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableLink >> configureToUpdate: aCheckable fromLinkedObject: anObjectOrValuable [

	| handler |
	handler := aCheckable
		           addEventHandlerOn: ToAddedToSpaceEvent
		           do: [ :event |
			           aCheckable checked:
				           (self read: anObjectOrValuable for: aCheckable) ].
	self addedHandler: handler in: aCheckable
]

{ #category : #initialization }
ToCheckableLink >> configureToUpdateLinkedObject: anObjectOrValuable from: aCheckable [

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
