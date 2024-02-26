Class {
	#name : #ToSecondarySelectionCommandAppliedEvent,
	#superclass : #ToCommandAppliedEvent,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #sending }
ToSecondarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject secondarySelectionCommandAppliedEvent: self
]
