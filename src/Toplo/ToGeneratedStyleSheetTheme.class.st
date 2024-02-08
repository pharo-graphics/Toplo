Class {
	#name : #ToGeneratedStyleSheetTheme,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRules [

	| visitor |
	visitor := ToThemeToSourceCodeVisitor new.
	self accept: visitor.
	self class
		compile: visitor formatedContents
		classified: #'initialization - generated'
]

{ #category : #'as yet unclassified' }
ToGeneratedStyleSheetTheme >> compileInitialiazeStyleRulesWithTokens: aCollectionOfTokkens [

	| visitor |
	
	visitor := ToThemeToSourceCodeVisitor new.
	self accept: visitor.
	self class
		compile: visitor formatedContents
		classified: #'initialization - generated'.
	
	self compileInitialiazeStyleRules.
	"Compile comment on self"
	"Format on self"
]
