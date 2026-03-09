Class {
	#name : #ToCheckableCheckRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToCheckableCheckRequestEvent >> sendTo: anObject [

	anObject checkableCheckRequestEvent: self
]
