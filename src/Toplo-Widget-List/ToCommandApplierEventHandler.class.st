Class {
	#name : #ToCommandApplierEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplierEventHandler >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	self subclassResponsibility 
]

{ #category : #'api - accessing' }
ToCommandApplierEventHandler >> eventsToHandle [

	^ { ToElementCommandAddedEvent. }
]
