Class {
	#name : #ToApplicableCommand,
	#superclass : #Object,
	#instVars : [
		'command',
		'operator',
		'target'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - processing' }
ToApplicableCommand >> apply [

	self operator applyCommand: self command for: self target
]

{ #category : #accessing }
ToApplicableCommand >> command [

	^ command
]

{ #category : #accessing }
ToApplicableCommand >> command: aCommand [

	command := aCommand
]

{ #category : #accessing }
ToApplicableCommand >> operator [

	^ operator
]

{ #category : #accessing }
ToApplicableCommand >> operator: aCommandOperator [

	operator := aCommandOperator
]

{ #category : #accessing }
ToApplicableCommand >> target [

	^ target
]

{ #category : #accessing }
ToApplicableCommand >> target: anObject [

	target := anObject
]
