Class {
	#name : #ToSelectionModelCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #accessing }
ToSelectionModelCommandEvent >> command [

	^ command
]

{ #category : #accessing }
ToSelectionModelCommandEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]
