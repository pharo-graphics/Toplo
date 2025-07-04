Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> configureToUpdateLinkedObject: aCheckableGroup from: anElement [

	| handler |
	handler := aCheckableGroup
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event | self runWithEvent: event  ].		
	self addedHandler: handler in: aCheckableGroup for: nil.

	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
			           self
				           launchWithLinkedObject: aCheckableGroup
				           from: anElement
				           onEvent: event sourceEvent
				           withValue: aCheckableGroup checkedList ].
	self addedHandler: handler in: self for: nil
]
