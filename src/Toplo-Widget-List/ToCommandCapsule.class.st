Class {
	#name : #ToCommandCapsule,
	#superclass : #Object,
	#instVars : [
		'command',
		'target'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToCommandCapsule >> command [

	^ command
]

{ #category : #accessing }
ToCommandCapsule >> command: aCommand [

	command := aCommand
]

{ #category : #accessing }
ToCommandCapsule >> target [

	^ target
]

{ #category : #accessing }
ToCommandCapsule >> target: anObject [

	target := anObject
]
