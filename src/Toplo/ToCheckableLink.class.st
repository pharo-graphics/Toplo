Class {
	#name : #ToCheckableLink,
	#superclass : #ToPropertyLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableLink >> configureToUpdate: aCheckable fromModel: aModel [

	| handler |
	handler := aCheckable
		           addEventHandlerOn: ToAddedToSpaceEvent
		           do: [ :event |
			           aCheckable checked: (self read: aModel) ].
	self addedHandler: handler in: aCheckable
]

{ #category : #initialization }
ToCheckableLink >> configureToUpdateModel: aModel from: aCheckable [

	| handler |
	handler := aCheckable
		           addEventHandlerOn: ToCheckableCheckEvent
		           do: [ :event |
			           event consume.
			           self applyChangeOn: aModel with: event current ].
	self addedHandler: handler in: aCheckable
]
