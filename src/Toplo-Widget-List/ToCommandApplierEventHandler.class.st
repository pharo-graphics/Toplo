Class {
	#name : #ToCommandApplierEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	self subclassResponsibility 
]

{ #category : #'api - accessing' }
ToCommandApplierEventHandler >> eventsToHandle [

	^ { ToElementCommandAddedEvent. }
]
