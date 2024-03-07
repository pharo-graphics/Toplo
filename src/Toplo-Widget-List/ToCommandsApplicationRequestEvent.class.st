Class {
	#name : #ToCommandsApplicationRequestEvent,
	#superclass : #ToCommandEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToCommandsApplicationRequestEvent >> sendTo: anObject [

	anObject commandsApplicationRequestEvent: self
]
