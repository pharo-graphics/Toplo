Class {
	#name : #ToCommandAppliedEvent,
	#superclass : #ToCommandEvent,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #sending }
ToCommandAppliedEvent >> sendTo: anObject [

	anObject commandAppliedEvent: self
]
