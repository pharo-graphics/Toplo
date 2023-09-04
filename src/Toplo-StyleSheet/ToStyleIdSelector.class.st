Class {
	#name : #ToStyleIdSelector,
	#superclass : #ToStyleSelector,
	#instVars : [
		'id'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #accessing }
ToStyleIdSelector >> id [

	^ id
]

{ #category : #accessing }
ToStyleIdSelector >> id: aSymbol [

	id := aSymbol
]
