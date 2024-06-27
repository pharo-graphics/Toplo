Class {
	#name : #ToCommandApplicationTaskActivationEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #sending }
ToCommandApplicationTaskActivationEvent >> sendTo: anObject [

	anObject elementCommandApplicationTaskActivationEvent: self
]
