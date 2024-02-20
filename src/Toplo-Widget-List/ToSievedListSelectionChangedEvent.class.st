Class {
	#name : #ToSievedListSelectionChangedEvent,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'pattern',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToSievedListSelectionChangedEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToSievedListSelectionChangedEvent >> pattern: aPattern [

	pattern := aPattern
]

{ #category : #accessing }
ToSievedListSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSievedListSelectionChangedEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
