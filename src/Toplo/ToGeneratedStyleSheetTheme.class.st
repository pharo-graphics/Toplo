Class {
	#name : #ToGeneratedStyleSheetTheme,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRules [

	| visitor dictionary others sourceCode expr formatedSourceCode |
	visitor := ToThemeToSourceCodeVisitor new.

	dictionary := Dictionary new.
	others := OrderedCollection new.
	self styleRules do: [ :each |
		each selector isStyleSelector
			ifTrue: [
				dictionary
					at: each selector type
					ifPresent: [ :list | list add: each ]
					ifAbsentPut: [
						OrderedCollection new
							add: each;
							yourself ] ]
			ifFalse: [ others add: each ] ].

	self styleRules
		select: [ :each | each selector type ]
		thenDo: [ :type |
		(dictionary at: type) do: [ :each | each accept: visitor ] ].
	
	others do: [ :each | ].

	self accept: visitor.
	sourceCode := ('initializeStyleRules<r>"'
	               , self generatedDefaultComment
	               , '"<generated: ''StyleSheetTheme''><r><r>')
		              expandMacros.
	sourceCode := sourceCode , visitor contents.

	expr := RBParser parseMethod: sourceCode.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self class
		compile: formatedSourceCode
		classified: #'initialization - generated'
]

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRulesWithAllTokens: aCollectionOfTokkens [

	| visitor sourceCode expr formatedSourceCode |
	visitor := ToThemeToSourceCodeVisitor new.
	(ToTokensHolderForGeneration new
		 tokens: aCollectionOfTokkens;
		 yourself) accept: visitor.

	sourceCode := ('defaultTokenProperties<r>"'
	               , self generatedDefaultComment , '"<r><r>^ ')
		              expandMacros.
	sourceCode := sourceCode , visitor contents.

	expr := RBParser parseMethod: sourceCode.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self class class
		compile: formatedSourceCode
		classified: #'accessing - generated'.

	self compileInitialiazeStyleRules
]

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRulesWithNewTokensOnly: aCollectionOfTokkens [

	| tokensToSerialize |
	tokensToSerialize := aCollectionOfTokkens reject: [ :each | super defaultTokenProperties includes: each ].
		self compileInitialiazeStyleRulesWithTokens: aCollectionOfTokkens
]

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRulesWithTokens: aCollectionOfTokkens [

	| tokensToSerialize visitor sourceCode expr formatedSourceCode |
	tokensToSerialize := aCollectionOfTokkens reject: [ :each |
		                     super class defaultTokenProperties includes: each ].
	visitor := ToThemeToSourceCodeVisitor new.
	(ToTokensHolderForGeneration new
		 tokens: tokensToSerialize;
		 yourself) accept: visitor.


	sourceCode := ('defaultTokenProperties<r>"'
	               , self generatedDefaultComment
	               , '"<r><r>^ super defaultTokenProperties , ')
		              expandMacros.
	sourceCode := sourceCode , visitor contents.

	expr := RBParser parseMethod: sourceCode.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self class class
		compile: formatedSourceCode
		classified: #'accessing - generated'.

	self compileInitialiazeStyleRules
]

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRulesWithoutTokens [

	| sourceCode expr formatedSourceCode |


	sourceCode := ('defaultTokenProperties<r>"'
	               , self generatedDefaultComment
	               , '"<r><r>^ super defaultTokenProperties')
		              expandMacros.

	expr := RBParser parseMethod: sourceCode.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self class class
		compile: formatedSourceCode
		classified: #'accessing - generated'.

	self compileInitialiazeStyleRules
]

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> generatedDefaultComment [

	^ 'This class has been generated using ToThemeToSourceCodeVisitor.<r><r><t>By: <1s><r><t><2s> <3s>'
		  expandMacrosWith: Author uniqueInstance fullName
		  with: Date today yyyymmdd
		  with: Time now print24
]