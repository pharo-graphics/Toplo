Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> onWidget: aCheckGroupOwner [

	| handler |
	super onWidget: aCheckGroupOwner.
	handler := aCheckGroupOwner
		           addEventHandlerOn: ToCheckableGroupChangedEvent
		           do: [ :event | self runWithEvent: event ].
	self addedHandler: handler in: aCheckGroupOwner
]
