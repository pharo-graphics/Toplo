Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> link: anObjectOrValuable withWidget: aCheckable [

	| handler |
	handler := aCheckable
		           addEventHandlerOn: ToCheckableChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: aCheckable for: aCheckable.

	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
				           self
					           onRunLinkActionRequest: event
					           withLinkedObject: anObjectOrValuable
					           fromWidget: aCheckable
					           withValue: aCheckable checked ].
	self addedHandler: handler in: self for: aCheckable
]

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
				           self
					           onRunLinkActionRequest: event
					           onWidget: aCheckable
					           withValue: aCheckable checked ].
	self addedHandler: handler in: self for: aCheckable
]
