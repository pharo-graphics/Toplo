Class {
	#name : #ToListDisabledSelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListDisabledSelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListDisabledSelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListDisabledSelectionChangedEvent >> selectionModel: anObject [

	selectionModel := anObject
]

{ #category : #sending }
ToListDisabledSelectionChangedEvent >> sendTo: anObject [

	anObject listDisabledSelectionChangedEvent: self
]
