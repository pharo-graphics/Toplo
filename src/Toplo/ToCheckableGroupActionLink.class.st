Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> onWidget: anElement [

	| handler |
	handler := anElement
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: anElement for: nil.

	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
		           self onRunLinkActionRequest: event onWidget: anElement ].
	self addedHandler: handler in: self for: nil
]
