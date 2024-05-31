Class {
	#name : #ToCommandApplicationTaskActivationEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #sending }
ToCommandApplicationTaskActivationEvent >> sendTo: anObject [

	anObject elementCommandApplicationTaskActivationEvent: self
]
