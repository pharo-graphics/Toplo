Class {
	#name : #ToThemeModel,
	#superclass : #Object,
	#instVars : [
		'theme',
		'tokensModel',
		'styleRulesModel'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #compiling }
ToThemeModel >> compileOn: aTheme [

	self compileTokensOn: aTheme.
	self compileStyleRulesOn: aTheme.
	self compileScriptOn: aTheme
]

{ #category : #compiling }
ToThemeModel >> compileOnCurrentTheme [

	self compileOn: self theme
]

{ #category : #compiling }
ToThemeModel >> compileScriptOn: aTheme [

	| formatedSourceCode expr sourceCode |
	sourceCode := 'edit
	<script>
	ToThemeEditorPresenter new
	theme: self new;
	open'.
	expr := RBParser parseMethod: sourceCode.
	formatedSourceCode := RBSimpleFormatter format: expr.

	aTheme class class
		compile: formatedSourceCode
		classified: #'scripting - generated'
]

{ #category : #compiling }
ToThemeModel >> compileSingleStyleRules: aStyleRuleModel on: aTheme [

	| formatedSourceCode expr ruleStream |
	ruleStream := String new writeStream.
	aStyleRuleModel asSourceCodeOn: ruleStream.
	expr := RBParser parseMethod: ruleStream contents expandMacros.
	formatedSourceCode := RBSimpleFormatter format: expr.

	aTheme class
		compile: formatedSourceCode
		classified: #'initialization - generated'.
]

{ #category : #compiling }
ToThemeModel >> compileStyleRulesOn: aTheme [

	self compileSingleStyleRules: self styleRulesModel on: aTheme.
	self styleRulesModel dictionary valuesDo: [ :each |
		self compileSingleStyleRules: each on: aTheme. ]
]

{ #category : #compiling }
ToThemeModel >> compileTokensOn: aTheme [

	| formatedSourceCode expr tokenStream |
	self tokensModel shouldCompile ifFalse: [ ^ self ].
	tokenStream := String new writeStream.
	self tokensModel asSourceCodeOn: tokenStream.
	expr := RBParser parseMethod: tokenStream contents expandMacros.
	formatedSourceCode := RBSimpleFormatter format: expr.

	aTheme class class
		compile: formatedSourceCode
		classified: #'accessing - generated'.

]

{ #category : #'as yet unclassified' }
ToThemeModel >> doHeritToken [

	self tokensModel strategy: ToTokensHeritFromParentStrategy new
]

{ #category : #'as yet unclassified' }
ToThemeModel >> doNotHeritToken [

	self tokensModel strategy: ToTokensDoNotHeritFromParentStrategy new
]

{ #category : #'as yet unclassified' }
ToThemeModel >> doNotModifyToken [

	self tokensModel strategy: ToTokensDoNotCompileStrategy new
]

{ #category : #initialization }
ToThemeModel >> initialize [

	tokensModel := ToTokensModel new.
	styleRulesModel := ToTypeStyleRulesModel new selector: #initializeStyleRules; yourself
]

{ #category : #'as yet unclassified' }
ToThemeModel >> onlyDifferentTokens [

	self tokensModel strategy:
		(ToTokensOnlyDifferentStrategy new parentTokens:
			 self theme class superclass defaultTokenProperties); yourself
]

{ #category : #'as yet unclassified' }
ToThemeModel >> styleRulesModel [

	^ styleRulesModel
]

{ #category : #'as yet unclassified' }
ToThemeModel >> theme [

	^ theme
]

{ #category : #'as yet unclassified' }
ToThemeModel >> theme: aToStyleSheetTheme [

	theme := aToStyleSheetTheme.
	self styleRulesModel styleRules: theme styleRules
]

{ #category : #accessing }
ToThemeModel >> tokens: aCollection [

	self tokensModel tokens: aCollection
]

{ #category : #'as yet unclassified' }
ToThemeModel >> tokensModel [

	^ tokensModel
]
