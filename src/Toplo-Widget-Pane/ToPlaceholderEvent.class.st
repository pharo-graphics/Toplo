Class {
	#name : #ToPlaceholderEvent,
	#superclass : #BlEvent,
	#instVars : [
		'placeholder'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #accessing }
ToPlaceholderEvent >> placeholder [

	^ placeholder 
]

{ #category : #accessing }
ToPlaceholderEvent >> placeholder: aPlaceholder [

	placeholder := aPlaceholder
]
