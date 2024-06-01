Class {
	#name : #ToElementCommandAppliedEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToElementCommandAppliedEvent >> sendTo: anObject [

		anObject elementCommandAppliedEvent: self
]
