Class {
	#name : #ToTokensOnlyDifferentStrategy,
	#superclass : #ToTokensStrategy,
	#instVars : [
		'parentTokens'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToTokensOnlyDifferentStrategy >> asSourceCodeWith: aCollection [

	| visitor tokens |
	tokens := aCollection reject: [ :each |
		          self parentTokens includes: each ].
	visitor := ToThemeToSourceCodeVisitor new.
	(ToTokensHolderForGeneration new
		 tokens: tokens;
		 yourself) accept: visitor.


	^ '^ super defaultTokenProperties , ' , visitor contents
]

{ #category : #converting }
ToTokensOnlyDifferentStrategy >> parentTokens [

	^ parentTokens
]

{ #category : #converting }
ToTokensOnlyDifferentStrategy >> parentTokens: aCollection [

	parentTokens := aCollection
]
