Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> onWidget: aCheckable [

	| handler |
	handler := aCheckable
		           addEventHandlerOn: ToCheckableChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: aCheckable for: aCheckable.
	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
		           self onRunLinkActionRequest: event onWidget: aCheckable ].
	self addedHandler: handler in: self for: aCheckable
]
