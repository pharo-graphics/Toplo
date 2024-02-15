Class {
	#name : #ToThemeEditorEventListenerSpecializedActionPresenter,
	#superclass : #ToThemeEditorEventListenerSpecializedPresenter,
	#instVars : [
		'eventListener',
		'actionInput'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #layout }
ToThemeEditorEventListenerSpecializedActionPresenter >> actionInput [

	^ actionInput
]

{ #category : #layout }
ToThemeEditorEventListenerSpecializedActionPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpLabelPresenter new
				   label: 'Action';
				   yourself)
		  expand: false;
		  add: self actionInput expand: true;
		  yourself
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedActionPresenter >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedActionPresenter >> eventListener: anObject [

	eventListener := anObject.
	self updatePresenter.
]

{ #category : #initialization }
ToThemeEditorEventListenerSpecializedActionPresenter >> initializePresenters [

	actionInput := SpCodePresenter new
		             beForScripting;
		             yourself
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedActionPresenter >> makeNewEventListener [

	| action |
	action := self actionInput
		          evaluate: self actionInput text
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

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedActionPresenter >> textForActionInputWhenNil [

	^ '"Select an event listener."'
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventListenerSpecializedActionPresenter >> textForActionInputWhenProperty [

	^ '"Write a blockClosure."'
]

{ #category : #accessing }
ToThemeEditorEventListenerSpecializedActionPresenter >> updatePresenter [

	self eventListener ifNil: [
		self actionInput text: self textForActionInputWhenNil.
		^ self ].
	self eventListener isAction ifFalse: [
		self actionInput text: self textForActionInputWhenProperty.
		^ self ].
	self actionInput text: self eventListener action printString
]
