Class {
	#name : #ToAddButtonClickedEvent,
	#superclass : #ToIconicButtonClickedEvent,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToAddButtonClickedEvent >> sendTo: anObject [

	anObject addButtonClickedEvent: self
]
