Class {
	#name : #ToCommandApplicationTaskActivationEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #sending }
ToCommandApplicationTaskActivationEvent >> sendTo: anObject [

	anObject elementCommandApplicationTaskActivationEvent: self
]
