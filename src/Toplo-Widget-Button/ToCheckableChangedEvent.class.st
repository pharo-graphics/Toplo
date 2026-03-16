Class {
	#name : #ToCheckableChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable  - protocol' }
ToCheckableChangedEvent class >> checked: aBoolean [

	^ self new
		  checked: aBoolean;
		  yourself
]

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
