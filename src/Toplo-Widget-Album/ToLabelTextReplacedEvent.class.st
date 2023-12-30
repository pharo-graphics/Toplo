Class {
	#name : #ToLabelTextReplacedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #sending }
ToLabelTextReplacedEvent >> sendTo: anObject [

	anObject labelTextReplacedEvent: self
]

{ #category : #accessing }
ToLabelTextReplacedEvent >> text [

	^ text
]

{ #category : #accessing }
ToLabelTextReplacedEvent >> text: aText [

	text := aText
]
