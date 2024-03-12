Class {
	#name : #ToElementCommandAddedEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #sending }
ToElementCommandAddedEvent >> sendTo: anObject [

	anObject elementCommandAddedEvent: self
]
