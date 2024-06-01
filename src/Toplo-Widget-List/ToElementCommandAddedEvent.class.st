Class {
	#name : #ToElementCommandAddedEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToElementCommandAddedEvent >> sendTo: anObject [

	anObject elementCommandAddedEvent: self
]
