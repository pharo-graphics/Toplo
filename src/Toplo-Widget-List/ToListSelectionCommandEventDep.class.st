Class {
	#name : #ToListSelectionCommandEventDep,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #accessing }
ToListSelectionCommandEventDep >> command [

	^ command
]

{ #category : #accessing }
ToListSelectionCommandEventDep >> command: aListSelectionCommand [

	command := aListSelectionCommand
]

{ #category : #sending }
ToListSelectionCommandEventDep >> sendTo: anObject [

	anObject listSelectionCommandEvent: self
]
