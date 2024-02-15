Class {
	#name : #ToThemeEditorRuleSelectorEditor,
	#superclass : #SpPresenter,
	#traits : 'TToThemeEditorObservable + TToThemeEditorRulesTreeObserver + TToThemeEditorPresenterWithApplyButton',
	#classTraits : 'TToThemeEditorObservable classTrait + TToThemeEditorRulesTreeObserver classTrait + TToThemeEditorPresenterWithApplyButton classTrait',
	#instVars : [
		'codeInput',
		'styleRule'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-ruleSelectorEditor'
}

{ #category : #accessing }
ToThemeEditorRuleSelectorEditor >> actionApplyButton [

	| compiledObject |
	compiledObject := codeInput
		                  evaluate: codeInput text
		                  onCompileError: [ :err | ^ self ]
		                  onError: [ :err | ^ err pass ].
	(compiledObject isKindOf: ToElementSelector) ifFalse: [
		ToThemeEditorWrongObjectError new signal:
			'Expected a ToElementSelector.' ].
	self styleRule selector: compiledObject.
	self observers do: [ :each | each styleRuleUpdated: self styleRule ]
]

{ #category : #accessing }
ToThemeEditorRuleSelectorEditor >> codeInput [

	^ codeInput
]

{ #category : #accessing }
ToThemeEditorRuleSelectorEditor >> controller [

	^ self
]

{ #category : #layout }
ToThemeEditorRuleSelectorEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: self topLayout
		  expand: false;
		  add: self codeInput height: 120;
		  yourself
]

{ #category : #initialization }
ToThemeEditorRuleSelectorEditor >> initializePresenters [

	codeInput := SpCodePresenter new
		             beForScripting;
		             yourself.
	self enabled: false
]

{ #category : #specs }
ToThemeEditorRuleSelectorEditor >> panelName [

	^ 'Rule Selector Editor'
]

{ #category : #initialization }
ToThemeEditorRuleSelectorEditor >> selectedRuleChanged: aToStyleRule [

	self styleRule: aToStyleRule

	
]

{ #category : #'as yet unclassified' }
ToThemeEditorRuleSelectorEditor >> styleRule [

	^ styleRule
]

{ #category : #'as yet unclassified' }
ToThemeEditorRuleSelectorEditor >> styleRule: aStyleRule [

	styleRule := aStyleRule.
	self updatePresenter.
	
]

{ #category : #accessing }
ToThemeEditorRuleSelectorEditor >> theme: aToTheme [

	self codeInput beForObject: aToTheme
]

{ #category : #'as yet unclassified' }
ToThemeEditorRuleSelectorEditor >> updatePresenter [

	| interpreter |
	self enabled: self styleRule isNotNil.
	self styleRule ifNil: [
		self codeInput text: '"Select a rule on the left."'.
		^ self ].
	interpreter := ToThemeToSourceCodeVisitor new.
	self styleRule selector accept: interpreter.
	self codeInput text: interpreter contents
]
