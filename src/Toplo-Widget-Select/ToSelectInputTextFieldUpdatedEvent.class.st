Class {
	#name : #ToSelectInputTextFieldUpdatedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #sending }
ToSelectInputTextFieldUpdatedEvent >> sendTo: anObject [

	anObject selectInputTextFieldUpdatedEvent: self
]
