Class {
	#name : #ToLabelEditorWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'editor'
	],
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #initialization }
ToLabelEditorWindowManager >> defaultPositionHook [

	" take into accound the gap used to compute the textField padding "
	^ [ :theWindow :theLabel :event |
	  (theLabel innerElement bounds inParent: self anchorRoot) topLeft
	  - ((theLabel valueOfTokenNamed: #'padding-content-HS')
		   @ (theLabel valueOfTokenNamed: #'padding-content-VS')) ]
]

{ #category : #accessing }
ToLabelEditorWindowManager >> editor [

	^ editor
]

{ #category : #'window handling' }
ToLabelEditorWindowManager >> onClosed [

	super onClosed.
	element onEditorClosed.
	editor := nil
]

{ #category : #'window handling' }
ToLabelEditorWindowManager >> onOpened [

	super onOpened.
	editor := element newEditor.
	editor text: element text copy.
	editor withSaveCapability.
	editor addEventHandlerOn: ToAlbumEditingFrontEvent do: [ :event |
		element dispatchEvent: event.
		self closeWindow ].
	element dispatchEvent: (ToLabelEditorCreatedEvent new editorElement: editor; yourself).
	currentWindow root addChild: editor.
	element onEditorOpened.
	element enqueueTask: (BlTaskAction new action: [
			 editor infinite requestFocus.
			 editor selecter
				 all;
				 apply ])
]

{ #category : #accessing }
ToLabelEditorWindowManager >> windowClass [

	^ ToLabelEditorWindow 
]
