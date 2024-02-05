Class {
	#name : #ToIdSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'id'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToIdSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self id = anObject id
]

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
