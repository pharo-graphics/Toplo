Class {
	#name : #ToCommandApplicationRequestEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToCommandApplicationRequestEvent >> sendTo: anObject [

	anObject commandApplicationRequestEvent: self
]
