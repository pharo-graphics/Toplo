Class {
	#name : #ToTripletContainerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'events handling' }
ToTripletContainerEventHandler >> clickAbortedEvent: anEvent [

	| aClickEvent target |
	target := anEvent currentTarget.
	(anEvent upEvent target withAllParentsInclude: target) ifFalse: [
		^ self ].
	aClickEvent := anEvent asClickEvent.
	target dispatchEvent: aClickEvent.
	anEvent consume
]

{ #category : #'api - accessing' }
ToTripletContainerEventHandler >> eventsToHandle [

	^ {
		  BlClickAbortedEvent }
]
