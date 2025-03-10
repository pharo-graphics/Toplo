Class {
	#name : #ToClickableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToClickableActionLink >> configureToUpdateLinkedObject: anObjectOrValuable from: aClickable [

	| handler |
	handler := aClickable
		           addEventHandlerOn: aClickable clickEventClass
		           do: [ :event |
			           self
				           launchWithLinkedObject: anObjectOrValuable 
				           from: aClickable
				           onEvent: event
				           withValue: nil ].
	self addedHandler: handler in: aClickable
]
