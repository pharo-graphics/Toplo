Class {
	#name : #ToTextReplacedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToTextReplacedEvent >> sendTo: anObject [

	anObject textReplacedEvent: self
]

{ #category : #accessing }
ToTextReplacedEvent >> text [

	^ text
]

{ #category : #accessing }
ToTextReplacedEvent >> text: aText [

	text := aText
]
