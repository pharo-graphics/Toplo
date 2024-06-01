Class {
	#name : #ToSecondarySelectionCommandAppliedEvent,
	#superclass : #ToElementCommandAppliedEvent,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #sending }
ToSecondarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject secondarySelectionCommandAppliedEvent: self
]
