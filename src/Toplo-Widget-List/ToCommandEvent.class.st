Class {
	#name : #ToCommandEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command',
		'commandTarget'
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
ToCommandEvent >> commandTarget [

	^ commandTarget
]

{ #category : #accessing }
ToCommandEvent >> commandTarget: anObject [

	commandTarget := anObject
]
