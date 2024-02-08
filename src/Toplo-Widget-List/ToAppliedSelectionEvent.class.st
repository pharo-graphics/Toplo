Class {
	#name : #ToAppliedSelectionEvent,
	#superclass : #ToSelectionCommandEvent,
	#instVars : [
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #copying }
ToAppliedSelectionEvent >> copySharedStatesFrom: anEvent [

	super copySharedStatesFrom: anEvent.
	self selectionChanged: anEvent selectionChanged 
]

{ #category : #accessing }
ToAppliedSelectionEvent >> selectionChanged [

	^ selectionChanged
]

{ #category : #accessing }
ToAppliedSelectionEvent >> selectionChanged: aBoolean [

	selectionChanged := aBoolean
]

{ #category : #sending }
ToAppliedSelectionEvent >> sendTo: anObject [

	anObject appliedSelectionEvent: self
]
