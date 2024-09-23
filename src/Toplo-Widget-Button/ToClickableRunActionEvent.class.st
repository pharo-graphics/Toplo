Class {
	#name : #ToClickableRunActionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #sending }
ToClickableRunActionEvent >> sendTo: anObject [

	anObject clickableRunActionEvent: self
]

{ #category : #accessing }
ToClickableRunActionEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToClickableRunActionEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
