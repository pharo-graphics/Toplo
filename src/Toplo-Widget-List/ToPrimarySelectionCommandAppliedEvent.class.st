Class {
	#name : #ToPrimarySelectionCommandAppliedEvent,
	#superclass : #ToCommandEvent,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #sending }
ToPrimarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject primarySelectionCommandAppliedEvent: self
]
