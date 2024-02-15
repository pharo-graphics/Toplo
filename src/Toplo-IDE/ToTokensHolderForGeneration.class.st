Class {
	#name : #ToTokensHolderForGeneration,
	#superclass : #Object,
	#instVars : [
		'tokens'
	],
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #visiting }
ToTokensHolderForGeneration >> accept: aVisitor [

	aVisitor visitTokensHolder: self
]

{ #category : #accessing }
ToTokensHolderForGeneration >> tokens [

	^ tokens
]

{ #category : #accessing }
ToTokensHolderForGeneration >> tokens: anObject [

	tokens := anObject
]
