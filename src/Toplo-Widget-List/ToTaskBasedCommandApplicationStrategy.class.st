Class {
	#name : #ToTaskBasedCommandApplicationStrategy,
	#superclass : #ToCommandApplicationStrategy,
	#instVars : [
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToTaskBasedCommandApplicationStrategy >> addCommand: aCommand [ 

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			commandApplier applyCommand: aCommand.
			^ self ] ].
	element enqueueTask:
		(BlTaskAction new action: [ commandApplier applyCommand: aCommand ])
]

{ #category : #initialization }
ToTaskBasedCommandApplicationStrategy >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #accessing }
ToTaskBasedCommandApplicationStrategy >> weak: anObject [

	weak := anObject
]
