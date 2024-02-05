Class {
	#name : #ToActionSelector,
	#superclass : #ToSimpleSelector,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Selectors'
}

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

{ #category : #converting }
ToActionSelector >> asSourceCode [

	^ self action printString , ' asActionSelector'
]
