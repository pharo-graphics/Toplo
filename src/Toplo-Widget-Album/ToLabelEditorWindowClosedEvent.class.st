Class {
	#name : #ToLabelEditorWindowClosedEvent,
	#superclass : #ToClosedEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
ToLabelEditorWindowClosedEvent >> text [

	^ text
]

{ #category : #accessing }
ToLabelEditorWindowClosedEvent >> text: aText [

	text := aText
]
