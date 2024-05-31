Class {
	#name : #ToElementCommandApplicationEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #sending }
ToElementCommandApplicationEvent >> sendTo: anObject [

		anObject elementCommandApplicationEvent: self
]
