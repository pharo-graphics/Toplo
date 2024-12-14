Class {
	#name : #ToClickableActionPerformedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #sending }
ToClickableActionPerformedEvent >> sendTo: anObject [

	anObject clickableActionPerformedEvent: self
]
