Class {
	#name : #ToSubSelectionModel,
	#superclass : #ToSelectionModel,
	#instVars : [
		'uniqueId'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToSubSelectionModel >> uniqueId [

	^ uniqueId
]

{ #category : #accessing }
ToSubSelectionModel >> uniqueId: aSymbol [

	uniqueId := aSymbol
]
