Class {
	#name : #ToCommandManagerEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #accessing }
ToCommandManagerEvent >> command [

	^ command
]

{ #category : #accessing }
ToCommandManagerEvent >> command: aCommand [

	command := aCommand
]
