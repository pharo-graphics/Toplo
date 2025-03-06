Class {
	#name : #ToCheckableLink,
	#superclass : #ToPropertyLink,
	#category : #'Toplo-Core-Properties'
}

{ #category : #initialization }
ToCheckableLink >> configureToUpdate: aCheckable fromModel: aModel [

	aCheckable
		addEventHandlerOn: BlElementAddedToSceneGraphEvent 
		do: [ :event | aCheckable checked: (self read: aModel) ]
]

{ #category : #initialization }
ToCheckableLink >> configureToUpdateModel: aModel from: aCheckable [

	aCheckable
		addEventHandlerOn: ToCheckableCheckEvent
		do: [ :event | self applyChangeOn: aModel with: event current ]
]
