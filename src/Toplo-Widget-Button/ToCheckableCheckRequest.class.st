Class {
	#name : #ToCheckableCheckRequest,
	#superclass : #BlEvent,
	#instVars : [
		'checked'
	],
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableCheckRequest >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckableCheckRequest >> checked: aBooleanOrIndeterminate [

	checked := aBooleanOrIndeterminate
]
