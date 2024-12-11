Class {
	#name : #ToLabelEditorWindowClosedEvent,
	#superclass : #ToClosedEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #accessing }
ToLabelEditorWindowClosedEvent >> text [

	^ text
]

{ #category : #accessing }
ToLabelEditorWindowClosedEvent >> text: aText [

	text := aText
]
