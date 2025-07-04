Class {
	#name : #ToTripletElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'events handling' }
ToTripletElementEventHandler >> clickAbortedEvent: anEvent [

	| aClickEvent target |
	target := anEvent currentTarget.
	(anEvent upEvent target withAllParentsInclude: target) ifFalse: [
		^ self ].
	aClickEvent := anEvent asClickEvent.
	target dispatchEvent: aClickEvent.
	anEvent consume
]

{ #category : #'api - accessing' }
ToTripletElementEventHandler >> eventsToHandle [

	^ {
		  ToTripletPartVisibilityChangeRequest.
		  BlClickAbortedEvent }
]

{ #category : #'event handling' }
ToTripletElementEventHandler >> tripletPartVisibilityChangeRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	target canHidePart ifFalse: [ ^ self ].
	target hideStart: anEvent hideStart.
	target hideMiddle: anEvent hideMiddle.
	target hideEnd: anEvent hideEnd
]
