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
		           do: [ :evt | anObject dispatchEvent: evt copy ].
	self addedHandler: handler in: aCheckableGroup.
	handler := anObject
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event |
			           self
				           launchWithLinkedObject: anObject
				           from: aCheckableGroup
				           onEvent: event
				           withValue: event checkedList ].
	self addedHandler: handler in: anObject
]
