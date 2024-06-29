Class {
	#name : #ToListSelectionChangeRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSelectionChangeRequestEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelectionChangeRequestEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListSelectionChangeRequestEvent >> sendTo: anObject [

	anObject listSelectionChangeRequestEvent: self
]
