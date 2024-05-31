Class {
	#name : #ToElementCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command',
		'operator'
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

{ #category : #accessing }
ToElementCommandEvent >> operator [

	^ operator
]

{ #category : #accessing }
ToElementCommandEvent >> operator: anOperator [

	operator := anOperator
]
