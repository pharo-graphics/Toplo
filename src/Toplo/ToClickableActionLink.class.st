Class {
	#name : #ToClickableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToClickableActionLink >> configureToUpdateModel: aModel from: aTarget [

	| handler |
	handler := aTarget
		           addEventHandlerOn: aTarget clickEventClass
		           do: [ :event |
			           | space time |
			           event consume.
			           space := aTarget space.
			           time := space ifNotNil: [ :sp | sp time ].
			           self applyChangeIn: aModel onEvent: event withValue: nil.
			           aTarget fireEvent: (ToClickableActionPerformedEvent new
					            fillFromTime: time;
					            yourself) ].
	self addedHandler: handler in: aTarget
]
