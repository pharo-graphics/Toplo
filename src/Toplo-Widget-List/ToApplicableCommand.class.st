Class {
	#name : #ToApplicableCommand,
	#superclass : #Object,
	#instVars : [
		'command',
		'operator'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - processing' }
ToApplicableCommand >> applyIn: aTarget [

	self operator applyCommand: self command in: aTarget
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
