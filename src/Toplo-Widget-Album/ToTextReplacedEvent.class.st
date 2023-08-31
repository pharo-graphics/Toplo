Class {
	#name : #ToTextReplacedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #accessing }
ToTextReplacedEvent >> text [

	^ text
]

{ #category : #accessing }
ToTextReplacedEvent >> text: aText [

	text := aText
]
