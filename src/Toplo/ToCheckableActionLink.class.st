Class {
	#name : #ToCheckableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToCheckableActionLink >> configureToUpdateModel: aModel from: aTarget [

	aTarget
		addEventHandlerOn: ToCheckableCheckEvent
		do: [ :event | self applyChangeOn: aModel with: event current ]
]
