Class {
	#name : #ToDirectCommandEventHandler,
	#superclass : #ToCommandEventHandler,
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'event handling' }
ToDirectCommandEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	| element |
	element := aCommandAddedEvent currentTarget.
	aCommandAddedEvent command notifyIn: element
]
