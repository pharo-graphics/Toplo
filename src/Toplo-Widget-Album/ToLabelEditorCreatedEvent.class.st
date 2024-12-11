Class {
	#name : #ToLabelEditorCreatedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'editorElement'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
ToLabelEditorCreatedEvent >> editorElement [

	^ editorElement
]

{ #category : #accessing }
ToLabelEditorCreatedEvent >> editorElement: anEditorElement [

	editorElement := anEditorElement
]
