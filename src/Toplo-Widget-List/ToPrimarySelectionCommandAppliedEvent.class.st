Class {
	#name : #ToPrimarySelectionCommandAppliedEvent,
	#superclass : #ToCommandAppliedEvent,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #sending }
ToPrimarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject primarySelectionCommandAppliedEvent: self
]
