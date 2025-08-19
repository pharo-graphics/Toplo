Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> linkWith: aCheckGroupOwner [

	| handler |
	super linkWith: aCheckGroupOwner.
	handler := aCheckGroupOwner
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: aCheckGroupOwner
]
