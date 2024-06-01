Class {
	#name : #ToPrimarySelectionCommandAppliedEvent,
	#superclass : #ToElementCommandAppliedEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToPrimarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject primarySelectionCommandAppliedEvent: self
]
