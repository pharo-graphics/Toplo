Class {
	#name : #ToSelectionRequestEvent,
	#superclass : #ToSelectionCommandEvent,
	#instVars : [
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #accessing }
ToSelectionRequestEvent >> selectionChanged [

	^ selectionChanged
]

{ #category : #accessing }
ToSelectionRequestEvent >> selectionChanged: aBoolean [

	selectionChanged := aBoolean
]

{ #category : #sending }
ToSelectionRequestEvent >> sendTo: anObject [

	anObject selectionRequestEvent: self
]
