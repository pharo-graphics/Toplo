Class {
	#name : #ToListSelectionCommandAppliedEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionCommandAppliedEvent >> command [

	^ command
]

{ #category : #accessing }
ToListSelectionCommandAppliedEvent >> command: anObject [

	command := anObject
]

{ #category : #accessing }
ToListSelectionCommandAppliedEvent >> selectionModel [

	^ command selectionModel
]

{ #category : #sending }
ToListSelectionCommandAppliedEvent >> sendTo: anObject [

	anObject listSelectionCommandAppliedEvent: self
]
