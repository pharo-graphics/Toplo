Class {
	#name : #ToTokensDoNotHeritFromParentStrategy,
	#superclass : #ToTokensStrategy,
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #converting }
ToTokensDoNotHeritFromParentStrategy >> asSourceCodeWith: aCollection [

	| visitor |
	visitor := ToThemeToSourceCodeVisitor new.
	(ToTokensHolderForGeneration new
		 tokens: aCollection;
		 yourself) accept: visitor.


	^ '^ ' , visitor contents
]
