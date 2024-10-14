Class {
	#name : #ToActionSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'as yet unclassified' }
ToActionSelector >> = anObject [

	super = anObject ifFalse: [ ^ false ].
	^ self action = anObject action
]

{ #category : #visiting }
ToActionSelector >> accept: aVisitor [

	aVisitor visitActionSelector: self
]

{ #category : #accessing }
ToActionSelector >> action [

	^ action
]

{ #category : #accessing }
ToActionSelector >> action: aValuable [
	" aValuable takes one element as argument "
	action := aValuable
]

{ #category : #converting }
ToActionSelector >> asActionSelector [

	^ self
]

{ #category : #comparing }
ToActionSelector >> hash [

	^ super hash bitXor: action hash
]
