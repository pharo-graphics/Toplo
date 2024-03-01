Class {
	#name : #ToListUnselectableSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListUnselectableSelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListUnselectableSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListUnselectableSelectionChangedEvent >> selectionModel: anObject [

	selectionModel := anObject
]

{ #category : #sending }
ToListUnselectableSelectionChangedEvent >> sendTo: anObject [

	anObject listUnselectableSelectionChangedEvent: self
]
