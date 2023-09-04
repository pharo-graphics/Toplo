Class {
	#name : #ToStyleClassSelector,
	#superclass : #ToStyleSelector,
	#instVars : [
		'elementClass'
	],
	#category : #'Toplo-StyleSheet-Model'
}

{ #category : #accessing }
ToStyleClassSelector >> elementClass [

	^ elementClass
]

{ #category : #accessing }
ToStyleClassSelector >> elementClass: aSymbol [

	elementClass := aSymbol
]
