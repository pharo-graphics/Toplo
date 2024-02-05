Class {
	#name : #ToploPanelInsideEventEditorForAction,
	#superclass : #ToploPanelInsideEventEditorForNotNil,
	#instVars : [
		'codeInput',
		'buttonApplyToRule',
		'styleRule'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> applyToRule [

	| compiledObject |
	compiledObject := codeInput
		                  evaluate: codeInput text
		                  onCompileError: [ :err | ^ self ]
		                  onError: [ :err | ^ err pass ].
	compiledObject ifNil: [ ^ self ].
	(compiledObject isKindOf: BlockClosure) ifFalse: [
		self informErrorWithCode.
		^ self ].
	self eventListener action: compiledObject
]

{ #category : #layout }
ToploPanelInsideEventEditorForAction >> buttonApplyToRule [

	^ buttonApplyToRule
]

{ #category : #accessing }
ToploPanelInsideEventEditorForAction >> codeInput [

	^ codeInput
]

{ #category : #layout }
ToploPanelInsideEventEditorForAction >> defaultLayout [

	^ super defaultLayout
		  add: self buttonApplyToRule expand: false;
		  add: self codeInput expand: true;
		  yourself
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> informErrorWithCode [

	(self confirm:
		 'Is not expected type. Do you want to restore previous state ?')
		ifTrue: [ self styleRule: self styleRule ]
]

{ #category : #initialization }
ToploPanelInsideEventEditorForAction >> initializePresenters [

	super initializePresenters.
	codeInput := SpCodePresenter new
		             beForScripting;
		             yourself.
	buttonApplyToRule := SpButtonPresenter new
		                     label: 'Create selected action bloc.';
		                     action: [ self applyToRule ];
		                     yourself
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> panelName [

	^ 'Rule edition'
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> updatePresenter [

	self codeInput text: self eventListener action printString
]
