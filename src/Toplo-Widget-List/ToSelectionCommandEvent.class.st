Class {
	#name : #ToSelectionCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #accessing }
ToSelectionCommandEvent >> command [

	^ command
]

{ #category : #accessing }
ToSelectionCommandEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]

{ #category : #sending }
ToSelectionCommandEvent >> sendTo: anObject [

	anObject selectionCommandEvent: self
]
