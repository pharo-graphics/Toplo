Class {
	#name : #ToElementCommandApplicationEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToElementCommandApplicationEvent >> sendTo: anObject [

		anObject elementCommandApplicationEvent: self
]
