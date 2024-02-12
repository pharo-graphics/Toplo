Class {
	#name : #ToSelectionRequestEvent,
	#superclass : #ToSelectionCommandEvent,
	#instVars : [
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #copying }
ToSelectionRequestEvent >> copySharedStatesFrom: anEvent [

	super copySharedStatesFrom: anEvent.
	self selectionChanged: anEvent selectionChanged 
]

{ #category : #accessing }
ToSelectionRequestEvent >> selectionChanged [

	^ selectionChanged ifNil: [ selectionChanged := false ]
]

{ #category : #accessing }
ToSelectionRequestEvent >> selectionChanged: aBoolean [

	selectionChanged := aBoolean
]

{ #category : #sending }
ToSelectionRequestEvent >> sendTo: anObject [

	anObject selectionRequestEvent: self
]
