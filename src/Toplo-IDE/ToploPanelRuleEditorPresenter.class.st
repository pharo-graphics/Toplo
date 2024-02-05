Class {
	#name : #ToploPanelRuleEditorPresenter,
	#superclass : #ToploPanelPresenter,
	#instVars : [
		'codeInput',
		'buttonApplyToRule',
		'styleRule'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #'as yet unclassified' }
ToploPanelRuleEditorPresenter >> applyToRule [

	| compiledObject |
	compiledObject := codeInput
		                  evaluate: codeInput text
		                  onCompileError: [ :err |
			                  ^ self ]
		                  onError: [ :err |
			                  ^ err pass ].
	compiledObject ifNil: [ ^ self ].
	(compiledObject isKindOf: ToElementSelector) ifFalse: [
		self informErrorWithCode.
		^ self ].
	self styleRule selector: compiledObject
]

{ #category : #accessing }
ToploPanelRuleEditorPresenter >> codeInput [

	^ codeInput
]

{ #category : #'as yet unclassified' }
ToploPanelRuleEditorPresenter >> informErrorWithCode [

	(self confirm:
		 'Is not expected type. Do you want to restore previous state ?')
		ifTrue: [ self styleRule: self styleRule ]
]

{ #category : #initialization }
ToploPanelRuleEditorPresenter >> initializePresenters [

	super initializePresenters.
	codeInput := SpCodePresenter new beForScripting; yourself.
	buttonApplyToRule := SpButtonPresenter new
		                     label: 'Apply to selected rule.';
		                     action: [ self applyToRule ];
		                     yourself.
	panelContent := SpBoxLayout newVertical
		                spacing: 4;
		                add: 'Selector' expand: false;
		                add: buttonApplyToRule expand: false;
		                add: codeInput height: 100;
		                yourself
]

{ #category : #'as yet unclassified' }
ToploPanelRuleEditorPresenter >> panelName [

	^ 'Rule edition'
]

{ #category : #'as yet unclassified' }
ToploPanelRuleEditorPresenter >> styleRule [

	^ styleRule
]

{ #category : #'as yet unclassified' }
ToploPanelRuleEditorPresenter >> styleRule: aStyleRule [

	styleRule := aStyleRule.
	self updatePresenter.
	
]

{ #category : #accessing }
ToploPanelRuleEditorPresenter >> theme: aToTheme [

	self codeInput beForObject: aToTheme
]

{ #category : #'as yet unclassified' }
ToploPanelRuleEditorPresenter >> updatePresenter [

	| interpreter |
	self styleRule ifNil: [
		self codeInput text: '"Select a rule on the left."'.
		^ self ].
	interpreter := ToSelectorPrinterAsSource new.
	self styleRule selector accept: interpreter.
	self codeInput text: interpreter contents
]
