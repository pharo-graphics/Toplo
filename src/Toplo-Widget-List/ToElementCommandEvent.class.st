Class {
	#name : #ToElementCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #accessing }
ToElementCommandEvent >> command [

	^ command
]

{ #category : #accessing }
ToElementCommandEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]
