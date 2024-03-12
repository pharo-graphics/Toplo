Class {
	#name : #ToElementCommandApplicationTaskActivationEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #sending }
ToElementCommandApplicationTaskActivationEvent >> sendTo: anObject [

	anObject elementCommandApplicationTaskActivationEvent: self
]
