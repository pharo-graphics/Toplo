Class {
	#name : #ToCheckableLink,
	#superclass : #ToWidgetWithModelLink,
	#category : #'Toplo-Core-Properties'
}

{ #category : #initialization }
ToCheckableLink >> configureToUpdateModel: aModel fromWidget: aControlWidget [

	aControlWidget
		addEventHandlerOn: ToCheckableCheckEvent
		do: [ :event | self write: event current to: aModel ]
]

{ #category : #initialization }
ToCheckableLink >> configureToUpdateWidget: aControlWidget fromModel: aModel [

	aControlWidget
		addEventHandlerOn: BlElementAddedToSceneGraphEvent 
		do: [ :event | aControlWidget checked: (self read: aModel) ]
]
