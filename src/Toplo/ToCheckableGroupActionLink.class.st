Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> link: aCheckableGroup withWidget: anElement [

	| handler |
	handler := aCheckableGroup
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: aCheckableGroup for: nil.

	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
				           self
					           onRunLinkActionRequest: event
					           withLinkedObject: aCheckableGroup
					           fromWidget: anElement
					           withValue: aCheckableGroup checkedList ].
	self addedHandler: handler in: self for: nil
]

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
				           self
					           onRunLinkActionRequest: event
					           onWidget: anElement
					           withValue: anElement checkedList ].
	self addedHandler: handler in: self for: nil
]
