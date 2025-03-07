Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> configureToUpdateModel: aModel from: aTarget [

	| handler |
	handler := aTarget
		           addEventHandlerOn: ToCheckableCheckEvent
		           do: [ :event |
			           self applyChangeIn: aModel onEvent: event withValue: event current ].
	self addedHandler: handler in: aTarget
]
