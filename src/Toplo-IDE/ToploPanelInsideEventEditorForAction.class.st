Class {
	#name : #ToploPanelInsideEventEditorForAction,
	#superclass : #ToploPanelInsideEventEditorAbstract,
	#instVars : [
		'codeInput',
		'styleRule'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #accessing }
ToploPanelInsideEventEditorForAction >> codeInput [

	^ codeInput
]

{ #category : #layout }
ToploPanelInsideEventEditorForAction >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
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
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> makeNewListener [

	| compiledObject |
	compiledObject := codeInput
		                  evaluate: codeInput text
		                  onCompileError: [ :err | ^ self ]
		                  onError: [ :err | ^ err pass ].
	compiledObject ifNil: [ ^ self ].
	(compiledObject isKindOf: BlockClosure) ifFalse: [
		self informErrorWithCode.
		^ self ].
	^ ToLookEventAction new
		  action: compiledObject;
		  yourself
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> panelName [

	^ 'Rule edition'
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForAction >> updatePresenter [

	super updatePresenter.
	self eventListener ifNil: [ ^ self ].
	self eventListener isAction ifFalse: [ ^ self ].
	self codeInput text: self eventListener action printString
]
