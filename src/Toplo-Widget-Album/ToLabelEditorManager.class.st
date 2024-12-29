Class {
	#name : #ToLabelEditorManager,
	#superclass : #ToContentEditorManager,
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #initializing }
ToLabelEditorManager >> defaultPlacement [

	^ super defaultPlacement
		  innerElement: element innerElement;
		  yourself
]

{ #category : #accessing }
ToLabelEditorManager >> editorClosedEventClass [

	^ ToLabelEditorClosedEvent 
]

{ #category : #accessing }
ToLabelEditorManager >> editorOpenedEventClass [

	^ ToLabelEditorOpenedEvent 
]

{ #category : #'instance creation' }
ToLabelEditorManager >> newEditorForLabel: aLabel [

	| ed |
	ed := aLabel innerElement newEditor.
	ed
		addEventHandlerOn: ToAlbumEditingFrontEvent
		do: [ :event | self closeWindow ].
	ed withSaveCapability.
	ed text: aLabel text copy.
	ed infinite requestFocus.
	ed selecter
		all;
		apply.
	^ ed
]

{ #category : #accessing }
ToLabelEditorManager >> popupWindowClass [

	^ ToLabelEditorWindow 
]
