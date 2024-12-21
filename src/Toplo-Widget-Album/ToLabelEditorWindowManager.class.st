Class {
	#name : #ToLabelEditorWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'editor'
	],
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #initializing }
ToLabelEditorWindowManager >> defaultPlacement [

	^ ToLabelEditorPlacement new
]

{ #category : #accessing }
ToLabelEditorWindowManager >> editor [

	^ editor
]

{ #category : #initialization }
ToLabelEditorWindowManager >> initialize [ 

	super initialize.
	
]

{ #category : #'instance creation' }
ToLabelEditorWindowManager >> newEditor [

	^ element newEditor
]

{ #category : #'window handling' }
ToLabelEditorWindowManager >> onClosed [

	super onClosed.
	element dispatchEvent: (ToLabelEditorClosedEvent new
			 editorElement: editor;
			 yourself).
	element dispatchEvent: (ToLabelEditorAfterClosingEvent new
			 editorElement: editor;
			 yourself).

	element currentEditorOpeningEventHandlers do: [ :h |
		element removeEventHandler: h ].
	element currentEditorClosingEventHandlers do: [ :h |
		element removeEventHandler: h ].

	editor := nil
]

{ #category : #'window handling' }
ToLabelEditorWindowManager >> onOpened [

	super onOpened.
	self openEditor.
	element dispatchEvent: (ToLabelEditorBeforeOpeningEvent new
			 editorElement: editor;
			 yourself).
	element enqueueTask: (BlTaskAction new action: [
			 editor infinite requestFocus.
			 editor selecter
				 all;
				 apply.
			 element dispatchEvent: (ToLabelEditorOpenedEvent new
					  editorElement: editor;
					  yourself) ])
]

{ #category : #'instance creation' }
ToLabelEditorWindowManager >> openEditor [

	editor := self newEditor.
	editor withSaveCapability.
	editor addEventHandlerOn: ToAlbumEditingFrontEvent do: [ :event |
		self closeWindow ].
	currentWindow root addChild: editor.


]

{ #category : #accessing }
ToLabelEditorWindowManager >> windowClass [

	^ ToLabelEditorWindow 
]
