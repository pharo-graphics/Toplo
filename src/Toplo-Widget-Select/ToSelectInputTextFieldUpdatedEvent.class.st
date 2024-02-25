Class {
	#name : #ToSelectInputTextFieldUpdatedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #sending }
ToSelectInputTextFieldUpdatedEvent >> sendTo: anObject [

	anObject selectInputTextFieldUpdatedEvent: self
]
