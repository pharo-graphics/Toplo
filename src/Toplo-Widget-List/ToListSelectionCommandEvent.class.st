Class {
	#name : #ToListSelectionCommandEvent,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #accessing }
ToListSelectionCommandEvent >> command [

	^ command
]

{ #category : #accessing }
ToListSelectionCommandEvent >> command: aListSelectionCommand [

	command := aListSelectionCommand
]

{ #category : #sending }
ToListSelectionCommandEvent >> sendTo: anObject [

	anObject listSelectionCommandEvent: self
]
