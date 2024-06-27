Class {
	#name : #ToDirectCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToDirectCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	aCommandAddedEvent currentTarget applyCommand: aCommandAddedEvent command
]
