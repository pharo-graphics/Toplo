Class {
	#name : #ToEnqueuedCommand,
	#superclass : #Object,
	#instVars : [
		'command',
		'applier'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToEnqueuedCommand >> applier [

	^ applier
]

{ #category : #accessing }
ToEnqueuedCommand >> applier: anObject [

	applier := anObject
]

{ #category : #accessing }
ToEnqueuedCommand >> command [

	^ command
]

{ #category : #accessing }
ToEnqueuedCommand >> command: aCommand [

	command := aCommand
]
