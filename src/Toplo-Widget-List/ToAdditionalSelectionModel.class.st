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

	^ uniqueId
]

{ #category : #accessing }
ToAdditionalSelectionModel >> uniqueId: aSymbol [

	uniqueId := aSymbol
]
