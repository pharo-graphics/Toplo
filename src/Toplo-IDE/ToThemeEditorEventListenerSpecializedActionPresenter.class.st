Class {
	#name : #ToThemeEditorEventListenerSpecializedActionPresenter,
	#superclass : #ToThemeEditorEventListenerSpecializedPresenter,
	#instVars : [
		'codeInput',
		'eventListener'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #layout }
ToThemeEditorEventListenerSpecializedActionPresenter >> codeInput [

	^ codeInput
]

{ #category : #layout }
ToThemeEditorEventListenerSpecializedActionPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpLabelPresenter new
				   label: 'Action';
				   yourself)
		  expand: false;
		  add: self codeInput expand: true;
		  yourself
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedActionPresenter >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedActionPresenter >> eventListener: anObject [

	eventListener := anObject.
	eventListener ifNil: [ ^ self ].
	eventListener isAction ifFalse: [ ^ self ].
	self updatePresenter.
	self codeInput text: self eventListener action printString
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedActionPresenter >> initializePresenters [

	codeInput := SpCodePresenter new beForScripting; yourself
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedActionPresenter >> makeNewEventListener [

	| action |
	action := self codeInput
		          evaluate: codeInput text
		          onCompileError: [ :err | ^ err pass ]
		          onError: [ :err | ^ err pass ].
	(action isKindOf: BlockClosure) ifFalse: [
		ToThemeEditorWrongObjectError new signal: 'Expected a BlockClosure.' ].
	action argumentCount = 1 ifFalse: [
		ToThemeEditorWrongObjectError new signal:
			'Expected a block closure with 1 argument.' ].
	^ ToLookEventAction new
		  action: action;
		  yourself
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedActionPresenter >> updatePresenter [

	self eventListener ifNil: [ self codeInput text: '"Select an event listener."'. ^ self ].
	self eventListener isPropertyWriter ifFalse: [ self codeInput text: '"Write a blockClosure."'. ^ self ].
	self codeInput text: self eventListener action printString
]
