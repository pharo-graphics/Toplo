Class {
	#name : #ToAdditionalSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'uniqueId'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToAdditionalSelectionModel >> uniqueId [

	uniqueId ifNil: [ Error signal: 'A uniqueId should not be nil' ].
	^ uniqueId
]

{ #category : #accessing }
ToAdditionalSelectionModel >> uniqueId: anObject [

	uniqueId := anObject
]
