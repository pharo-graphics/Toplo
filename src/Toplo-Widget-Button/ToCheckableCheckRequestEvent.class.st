Class {
	#name : #ToCheckableCheckRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #sending }
ToCheckableCheckRequestEvent >> sendTo: anObject [

	anObject checkableCheckRequestEvent: self
]
