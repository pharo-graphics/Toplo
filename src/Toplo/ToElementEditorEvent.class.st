Class {
	#name : #ToElementEditorEvent,
	#superclass : #BlEvent,
	#instVars : [
		'editorElement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'as yet unclassified' }
ToElementEditorEvent >> editorElement [

	^ editorElement
]

{ #category : #'as yet unclassified' }
ToElementEditorEvent >> editorElement: anEditorElement [

	editorElement := anEditorElement
]
