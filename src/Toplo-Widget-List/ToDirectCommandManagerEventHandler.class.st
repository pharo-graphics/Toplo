Class {
	#name : #ToDirectCommandManagerEventHandler,
	#superclass : #ToCommandManagerEventHandler,
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #'event handling' }
ToDirectCommandManagerEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	aCommandAddedEvent currentTarget applyCommand: aCommandAddedEvent command
]
