Class {
	#name : #ThemeModel,
	#superclass : #Object,
	#instVars : [
		'theme',
		'tokensModel',
		'styleRulesModel'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #compiling }
ThemeModel >> compileOnCurrentTheme [

	| formatedSourceCode expr tokenStream ruleStream |
	tokenStream := String new writeStream.
	self tokensModel asSourceCodeOn: tokenStream.
	expr := RBParser parseMethod: tokenStream contents expandMacros.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self theme class class
		compile: formatedSourceCode
		classified: #'accessing - generated'.

	ruleStream := String new writeStream.
	self styleRulesModel asSourceCodeOn: ruleStream.
	expr := RBParser parseMethod: ruleStream contents expandMacros.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self theme class
		compile: formatedSourceCode
		classified: #'initialization - generated'.
	
	self styleRulesModel dictionary valuesDo: [ :each | ruleStream := String new writeStream.
	each asSourceCodeOn: ruleStream.
	expr := RBParser parseMethod: ruleStream contents expandMacros.
	formatedSourceCode := RBSimpleFormatter format: expr.

	self theme class
		compile: formatedSourceCode
		classified: #'initialization - generated'. ]
]

{ #category : #'as yet unclassified' }
ThemeModel >> doHeritToken [

	self tokensModel strategy: ToTokensHeritFromParentStrategy new
]

{ #category : #'as yet unclassified' }
ThemeModel >> doNotHeritToken [

	self tokensModel strategy: ToTokensDoNotHeritFromParentStrategy new
]

{ #category : #initialization }
ThemeModel >> initialize [

	tokensModel := ToTokensModel new.
	styleRulesModel := ToTypeStyleRulesModel new selector: #initializeStyleRules; yourself
]

{ #category : #'as yet unclassified' }
ThemeModel >> onlyDifferentTokens [

	self tokensModel strategy:
		(ToTokensOnlyDifferentStrategy new parentTokens:
			 self theme class superclass defaultTokenProperties); yourself
]

{ #category : #'as yet unclassified' }
ThemeModel >> styleRulesModel [

	^ styleRulesModel
]

{ #category : #'as yet unclassified' }
ThemeModel >> theme [

	^ theme
]

{ #category : #'as yet unclassified' }
ThemeModel >> theme: aToStyleSheetTheme [

	theme := aToStyleSheetTheme.
	self styleRulesModel styleRules: theme styleRules
]

{ #category : #accessing }
ThemeModel >> tokens: aCollection [

	self tokensModel tokens: aCollection
]

{ #category : #'as yet unclassified' }
ThemeModel >> tokensModel [

	^ tokensModel
]
