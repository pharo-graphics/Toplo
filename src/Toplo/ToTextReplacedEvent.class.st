Class {
	#name : #ToTextReplacedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Labels'
}

{ #category : #accessing }
ToTextReplacedEvent >> text [

	^ text
]

{ #category : #accessing }
ToTextReplacedEvent >> text: aText [

	text := aText
]
