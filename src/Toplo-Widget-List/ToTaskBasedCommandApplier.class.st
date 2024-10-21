Class {
	#name : #ToTaskBasedCommandApplier,
	#superclass : #ToCommandApplier,
	#instVars : [
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToTaskBasedCommandApplier >> command: aCommand addedIn: aSelecter [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aSelecter applyCommand: aCommand.
			^ self ] ].
	element enqueueTask:
		(BlTaskAction new action: [ aSelecter applyCommand: aCommand ])
]

{ #category : #initialization }
ToTaskBasedCommandApplier >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #accessing }
ToTaskBasedCommandApplier >> weak: anObject [

	weak := anObject
]
