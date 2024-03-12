Class {
	#name : #ToCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToCommandEvent >> command [

	^ command
]

{ #category : #accessing }
ToCommandEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]
