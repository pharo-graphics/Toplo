Class {
	#name : #ToTaskBasedCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#instVars : [
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToTaskBasedCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

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
ToTaskBasedCommandApplierEventHandler >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #accessing }
ToTaskBasedCommandApplierEventHandler >> weak: anObject [

	weak := anObject
]
