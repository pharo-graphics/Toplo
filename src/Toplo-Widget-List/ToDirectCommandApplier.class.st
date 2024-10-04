Class {
	#name : #ToDirectCommandApplier,
	#superclass : #ToCommandApplier,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToDirectCommandApplier >> elementCommandAddedEvent: aCommandAddedEvent [

	aCommandAddedEvent currentTarget applyCommand: aCommandAddedEvent command
]
