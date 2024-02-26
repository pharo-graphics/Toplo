Class {
	#name : #ToListSecondarySelectionChangedEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListSecondarySelectionChangedEvent >> selectedIndexes [ 

	^ self selectionModel selectedIndexes 
]

{ #category : #accessing }
ToListSecondarySelectionChangedEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSecondarySelectionChangedEvent >> selectionModel: anObject [

	selectionModel := anObject
]

{ #category : #sending }
ToListSecondarySelectionChangedEvent >> sendTo: anObject [

	anObject listSecondarySelectionChangedEvent: self
]
