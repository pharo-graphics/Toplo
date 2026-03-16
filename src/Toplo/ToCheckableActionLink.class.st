Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> linkWith: aCheckable [

	| handler |
	super linkWith: aCheckable.
	handler := aCheckable
		           addEventHandlerOn: ToCheckableChangedEvent
		           do: [ :event | self requestNextRunWithEvent: event ].
	self addedHandler: handler in: aCheckable
]
