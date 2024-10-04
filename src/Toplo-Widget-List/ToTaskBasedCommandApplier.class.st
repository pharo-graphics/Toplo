Class {
	#name : #ToTaskBasedCommandApplier,
	#superclass : #ToCommandApplier,
	#instVars : [
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToTaskBasedCommandApplier >> elementCommandAddedEvent: aCommandAddedEvent [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aCommandAddedEvent currentTarget applyCommand:
				aCommandAddedEvent command.
			^ self ] ].
	element enqueueTask: (BlTaskAction new action: [
			 aCommandAddedEvent currentTarget applyCommand:
				 aCommandAddedEvent command ])
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
