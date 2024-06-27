Class {
	#name : #ToElementCommandApplicationRequest,
	#superclass : #ToCommandApplicationEvent,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #sending }
ToElementCommandApplicationRequest >> sendTo: anObject [

		anObject elementCommandApplicationRequest: self
]
