Class {
	#name : #ToClickableActionRequestEvent,
	#superclass : #ToUnanimityRequestEvent,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #sending }
ToClickableActionRequestEvent >> sendTo: anObject [

	anObject clickableActionRequestEvent: self
]
