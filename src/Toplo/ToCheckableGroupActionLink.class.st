Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> configureToUpdateLinkedObject: anObject from: aCheckableGroup [

	| handler |
	
	handler := aCheckableGroup
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event | self runWithEvent: event  ].		
	self addedHandler: handler in: aCheckableGroup.

	handler := self
		           addEventHandlerOn: ToRunLinkActionEvent
		           do: [ :event |
			           self
				           launchWithLinkedObject: anObject
				           from: aCheckableGroup
				           onEvent: event sourceEvent
				           withValue: aCheckableGroup checkedList ].
	self addedHandler: handler in: self
]
