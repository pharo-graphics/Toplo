Class {
	#name : #ToTargetedCommand,
	#superclass : #Object,
	#instVars : [
		'command',
		'operator',
		'target'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - processing' }
ToTargetedCommand >> apply [

	self operator applyCommand: self command for: self target
]

{ #category : #accessing }
ToTargetedCommand >> command [

	^ command
]

{ #category : #accessing }
ToTargetedCommand >> command: aCommand [

	command := aCommand
]

{ #category : #accessing }
ToTargetedCommand >> operator [

	^ operator
]

{ #category : #accessing }
ToTargetedCommand >> operator: aCommandOperator [

	operator := aCommandOperator
]

{ #category : #accessing }
ToTargetedCommand >> target [

	^ target
]

{ #category : #accessing }
ToTargetedCommand >> target: anObject [

	target := anObject
]
