Class {
	#name : #ToCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command',
		'commandOperator'
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

{ #category : #accessing }
ToCommandEvent >> commandOperator [

	^ commandOperator
]

{ #category : #accessing }
ToCommandEvent >> commandOperator: aCommandOperator [

	commandOperator := aCommandOperator
]
