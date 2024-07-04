Class {
	#name : #ToTaskBasedCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#instVars : [
		'element',
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToTaskBasedCommandApplierEventHandler >> element: anElement [

	element := anElement
]

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
