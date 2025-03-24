Class {
	#name : #ToAddButtonClickedEvent,
	#superclass : #ToIconicButtonClickedEvent,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #sending }
ToAddButtonClickedEvent >> sendTo: anObject [

	anObject addButtonClickedEvent: self
]
