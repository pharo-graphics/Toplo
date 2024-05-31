Class {
	#name : #ToDirectCommandEventHandler,
	#superclass : #ToCommandEventHandler,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'event handling' }
ToDirectCommandEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	aCommandAddedEvent command
		notifyAddedInOperator: aCommandAddedEvent currentTarget
]
