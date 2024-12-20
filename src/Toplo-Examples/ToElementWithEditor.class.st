Class {
	#name : #ToElementWithEditor,
	#superclass : #ToElement,
	#traits : 'TToElementWithContentEditor',
	#classTraits : 'TToElementWithContentEditor classTrait',
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'private-editing' }
ToElementWithEditor >> editorClosed: aToAlbum [ 

	
]

{ #category : #'private-editing' }
ToElementWithEditor >> editorOpened: aToAlbum [

	aToAlbum text: self background paint color asString.

	" flash if save requested with no text change "
	aToAlbum whenFlashRequestedDo: [ :event | event traceCr ].
	aToAlbum whenSaveRequestedDo: [ :event |
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
	aToAlbum whenSaveAcceptedDo: [ :event |
		| newColor |
		event traceCr.
		newColor := OpalCompiler new
			            source: event currentTarget text asString;
			            evaluate.
		self background: newColor ].
	aToAlbum whenCancelRequestedDo: [ :event | event traceCr ].
	" show edit feedback when text is edited "
	aToAlbum whenTextEditedDo: [ :event | event traceCr ]
]

{ #category : #initialization }
ToElementWithEditor >> initialize [

	super initialize.
	self whenEditorOpenedDo: [ :event |
		self editorOpened: event editorElement ].
	self whenEditorClosedDo: [ :event |
		self editorClosed: event editorElement ]
]

{ #category : #'t - element with content editor' }
ToElementWithEditor >> newEditor [

	^ ToAlbum new
		  size: 100 @ 100;
		  yourself
]
