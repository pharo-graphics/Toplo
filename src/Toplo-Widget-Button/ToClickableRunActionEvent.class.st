Class {
	#name : #ToClickableRunActionEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #sending }
ToClickableRunActionEvent >> sendTo: anObject [

	anObject clickableRunActionEvent: self
]
