Class {
	#name : #ToTaskBasedCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToTaskBasedCommandApplierEventHandler >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToTaskBasedCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	element isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent currentTarget applyCommand:
			aCommandAddedEvent command.
		^ self ].
	element enqueueTask: (BlTaskAction new action: [
			 aCommandAddedEvent currentTarget applyCommand:
				 aCommandAddedEvent command ])
]
