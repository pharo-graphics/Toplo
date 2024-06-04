Class {
	#name : #ToElementCommandAddedEvent,
	#superclass : #ToCommandManagerEvent,
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #sending }
ToElementCommandAddedEvent >> sendTo: anObject [

	anObject elementCommandAddedEvent: self
]
