Class {
	#name : #ToActionRunRequest,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #sending }
ToActionRunRequest >> sendTo: anObject [

	anObject actionRunRequest: self
]
