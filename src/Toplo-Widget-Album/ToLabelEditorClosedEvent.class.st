Class {
	#name : #ToLabelEditorClosedEvent,
	#superclass : #ToClosedEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
ToLabelEditorClosedEvent >> text [

	^ text
]

{ #category : #accessing }
ToLabelEditorClosedEvent >> text: aText [

	text := aText
]
