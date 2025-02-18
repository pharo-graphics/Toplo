Class {
	#name : #ToElementWithEditor,
	#superclass : #ToElement,
	#traits : 'TToElementWithContentEditor',
	#classTraits : 'TToElementWithContentEditor classTrait',
	#instVars : [
		'contents'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'t - element with content editor' }
ToElementWithEditor >> beforeEditorClosed: anEditor fromManager: aManager [

	contents := anEditor text
]

{ #category : #'t - element with content editor' }
ToElementWithEditor >> beforeEditorOpened: anEditor fromManager: aManager [

	anEditor
		addEventHandlerOn: ToAlbumEditingFrontEvent
		do: [ :event | aManager closeWindow ].

	anEditor text: (contents ifNil: [self background paint color asString]).
	anEditor requestFocus.
	anEditor selecter
		all;
		apply.

	" flash if save requested with no text change "
	anEditor whenFlashRequestedDo: [ :event | event traceCr ].
	anEditor whenSaveRequestedDo: [ :event |
		event unacceptedEdits
			ifTrue: [
				| newColor |
				newColor := OpalCompiler new
					            source: event currentTarget text asString;
					            failBlock: [ :err | ^ nil ];
					            evaluate.
				newColor ifNotNil: [ event accepted: true ] ]
			ifFalse: [ 'No text change' traceCr ] ].
	" hide edit feedback when save is accepted or cancelled "
	anEditor whenSaveAcceptedDo: [ :event |
		| newColor |
		event traceCr.
		newColor := OpalCompiler new
			            source: event currentTarget text asString;
			            evaluate.
		self background: newColor ].
	anEditor whenCancelRequestedDo: [ :event | event traceCr ].
	" show edit feedback when text is edited "
	anEditor whenTextEditedDo: [ :event | event traceCr ]
]

{ #category : #'t - element with content editor' }
ToElementWithEditor >> newEditorForManager: aManager [

	^ ToAlbum new
		  size: 100 @ 100;
		  withSaveCapability;
		  yourself
]

{ #category : #'t - element with content editor' }
ToElementWithEditor >> onInstalledEditorManager: aManager [


]

{ #category : #'t - element with content editor' }
ToElementWithEditor >> onUninstalledEditorManager: aManager [

	
]
