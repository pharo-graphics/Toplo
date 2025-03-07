Class {
	#name : #ToClickableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToClickableActionLink >> configureToUpdateModel: aModel from: aTarget [

	aTarget addEventHandlerOn: aTarget clickEventClass do: [ :event |
		| space time |
		space := aTarget space.
		time := space ifNotNil: [ :sp | sp time].
		self applyChangeOn: aModel with: nil.
		aTarget fireEvent: (ToClickableActionPerformedEvent new
				 fillFromTime: time;
				 yourself) ]
]
