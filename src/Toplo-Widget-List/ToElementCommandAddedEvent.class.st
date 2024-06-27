Class {
	#name : #ToElementCommandAddedEvent,
	#superclass : #ToCommandApplicationEvent,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #sending }
ToElementCommandAddedEvent >> sendTo: anObject [

	anObject elementCommandAddedEvent: self
]
