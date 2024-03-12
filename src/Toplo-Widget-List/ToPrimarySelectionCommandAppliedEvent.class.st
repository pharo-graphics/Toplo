Class {
	#name : #ToPrimarySelectionCommandAppliedEvent,
	#superclass : #ToElementCommandEvent,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #sending }
ToPrimarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject primarySelectionCommandAppliedEvent: self
]
