Class {
	#name : #ToCheckableChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableChangedEvent >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckableChangedEvent >> checked: anObject [

	checked := anObject
]

{ #category : #sending }
ToCheckableChangedEvent >> sendTo: anObject [

	anObject checkableChangedEvent: self
]
