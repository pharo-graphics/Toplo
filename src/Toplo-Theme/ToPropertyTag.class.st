Class {
	#name : #ToPropertyTag,
	#superclass : #Object,
	#instVars : [
		'name',
		'value'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #accessing }
ToPropertyTag >> name [

	^ name
]

{ #category : #accessing }
ToPropertyTag >> name: aSymbol [

	name := aSymbol
]

{ #category : #accessing }
ToPropertyTag >> value [

	^ value
]

{ #category : #accessing }
ToPropertyTag >> value: anObject [

	value := anObject
]
