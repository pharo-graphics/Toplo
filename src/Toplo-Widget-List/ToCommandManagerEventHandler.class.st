Class {
	#name : #ToCommandManagerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #'event handling' }
ToCommandManagerEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	self subclassResponsibility 
]

{ #category : #'api - accessing' }
ToCommandManagerEventHandler >> eventsToHandle [

	^ { ToElementCommandAddedEvent. }
]
