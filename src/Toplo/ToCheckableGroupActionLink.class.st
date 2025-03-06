Class {
	#name : #ToCheckableGroupActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-Properties'
}

{ #category : #initialization }
ToCheckableGroupActionLink >> configureToUpdateModel: aModel from: aTarget [

	aTarget
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self applyChangeOn: aModel with: event checkedList ]
]
