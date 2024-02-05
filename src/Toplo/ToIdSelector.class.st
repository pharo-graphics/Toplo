Class {
	#name : #ToIdSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'id'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #visiting }
ToIdSelector >> accept: aVisitor [

	aVisitor visitIdSelector: self
]

{ #category : #converting }
ToIdSelector >> asIdSelector [

	^ self
]

{ #category : #converting }
ToIdSelector >> asSourceCode [

	^ self id printString , ' asIdSelector'
]

{ #category : #accessing }
ToIdSelector >> id [

	^ id
]

{ #category : #accessing }
ToIdSelector >> id: aSymbol [

	id := aSymbol
]
