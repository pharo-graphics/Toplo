Class {
	#name : #ToCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command',
		'operator'
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
ToCommandEvent >> operator [

	^ operator
]

{ #category : #accessing }
ToCommandEvent >> operator: aCommandOperator [

	operator := aCommandOperator
]
