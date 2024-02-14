Class {
	#name : #ToSelectionCommandAppliedEvent,
	#superclass : #ToCommandEvent,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #sending }
ToSelectionCommandAppliedEvent >> sendTo: anObject [

	anObject commandAppliedEvent: self
]
