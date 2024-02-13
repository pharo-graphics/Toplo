Class {
	#name : #ToCommandAddedEvent,
	#superclass : #ToCommandEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToCommandAddedEvent >> sendTo: anObject [

	anObject commandAddedEvent: self
]
