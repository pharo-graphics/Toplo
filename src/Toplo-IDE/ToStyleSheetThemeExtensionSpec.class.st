Class {
	#name : #ToStyleSheetThemeExtensionSpec,
	#superclass : #ToSkinThemeExtensionSpec,
	#instVars : [
		'skin',
		'element'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #testing }
ToStyleSheetThemeExtensionSpec class >> isAbstract [

	^ self == ToStyleSheetThemeExtensionSpec
]

{ #category : #accessing }
ToStyleSheetThemeExtensionSpec >> element [
	^ element
]

{ #category : #accessing }
ToStyleSheetThemeExtensionSpec >> element: aBlElement [

	element := aBlElement.
	self updatePresenter
]

{ #category : #icons }
ToStyleSheetThemeExtensionSpec >> iconForSelector: aStyleRule [

	(self element isNil and: [ self skin isNil ]) ifTrue: [
		^ self noElementNoSkinIcon ].
	self skin ifNotNil: [
		(self skin isKindOf: ToStyleSheetSkin) ifFalse: [ ^ self notStyleSheetSkin ].
		(aStyleRule lookEventListeners includesAny:
			 self skin lookEventListeners) ifTrue: [
			^ self skinAndStyleRuleIcon ] ].
	self element ifNotNil: [
		(ToSelectorInterpreter new
			 check: aStyleRule selector
			 on: self element) ifTrue: [ ^ self selectorOkButNotSkin ] ].
	^ self selectorKo
]

{ #category : #icons }
ToStyleSheetThemeExtensionSpec >> noElementNoSkinIcon [
	^ self iconNamed: #blank
]

{ #category : #icons }
ToStyleSheetThemeExtensionSpec >> notStyleSheetSkin [

	^ self iconNamed: #blank
]

{ #category : #icons }
ToStyleSheetThemeExtensionSpec >> selectorKo [

^ self iconNamed: #smallCancel
]

{ #category : #icons }
ToStyleSheetThemeExtensionSpec >> selectorOkButNotSkin [
	
^ self iconNamed: #protocolProtected
]

{ #category : #defaults }
ToStyleSheetThemeExtensionSpec >> skin [

	^ skin
]

{ #category : #icons }
ToStyleSheetThemeExtensionSpec >> skinAndStyleRuleIcon [
^ self iconNamed: #smallOk
]
