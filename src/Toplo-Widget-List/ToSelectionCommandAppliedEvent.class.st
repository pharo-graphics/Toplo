Class {
	#name : #ToSelectionCommandAppliedEvent,
	#superclass : #ToCommandEvent,
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #sending }
ToSelectionCommandAppliedEvent >> sendTo: anObject [

	anObject commandAppliedEvent: self
]
