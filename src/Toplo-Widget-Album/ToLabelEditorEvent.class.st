Class {
	#name : #ToLabelEditorEvent,
	#superclass : #BlEvent,
	#instVars : [
		'editorElement'
	],
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #'as yet unclassified' }
ToLabelEditorEvent >> editorElement [

	^ editorElement
]

{ #category : #'as yet unclassified' }
ToLabelEditorEvent >> editorElement: anEditorElement [

	editorElement := anEditorElement
]
