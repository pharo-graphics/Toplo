Class {
	#name : #ToIdSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'id'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #comparing }
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

{ #category : #comparing }
ToIdSelector >> hash [

	^ super hash bitXor: id hash
]

{ #category : #accessing }
ToIdSelector >> id [

	^ id
]

{ #category : #accessing }
ToIdSelector >> id: aSymbol [

	id := aSymbol
]
