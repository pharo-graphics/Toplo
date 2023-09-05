Class {
	#name : #ToIdSelector,
	#superclass : #ToElementSelector,
	#instVars : [
		'id'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToIdSelector >> accept: aVisitor [

	aVisitor visitIdSelector: self
]

{ #category : #accessing }
ToIdSelector >> id [

	^ id
]

{ #category : #accessing }
ToIdSelector >> id: aSymbol [

	id := aSymbol
]
