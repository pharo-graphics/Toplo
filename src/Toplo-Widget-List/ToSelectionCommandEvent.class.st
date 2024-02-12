Class {
	#name : #ToSelectionCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToSelectionCommandEvent >> command [

	^ command
]

{ #category : #accessing }
ToSelectionCommandEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]
