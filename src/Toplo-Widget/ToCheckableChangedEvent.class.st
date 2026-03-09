Class {
	#name : #ToCheckableChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToCheckableChangedEvent >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckableChangedEvent >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #sending }
ToCheckableChangedEvent >> sendTo: anObject [

	anObject checkableChangedEvent: self
]
