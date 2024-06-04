Class {
	#name : #ToSelectInputTextFieldUpdatedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Select-textInput'
}

{ #category : #sending }
ToSelectInputTextFieldUpdatedEvent >> sendTo: anObject [

	anObject selectInputTextFieldUpdatedEvent: self
]
