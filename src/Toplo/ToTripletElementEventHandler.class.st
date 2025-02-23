Class {
	#name : #ToTripletElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'events handling' }
ToTripletElementEventHandler >> clickAbortedEvent: anEvent [

	| aClickEvent target |
	target := anEvent currentTarget.
	(anEvent upEvent target hasInParentChain: target) ifFalse: [ ^ self ].
	aClickEvent := anEvent asClickEvent.
	target dispatchEvent: aClickEvent.
	anEvent consume.
]

{ #category : #'api - accessing' }
ToTripletElementEventHandler >> eventsToHandle [

	^ {
		  BlClickAbortedEvent.
		  ToLayoutDirectionChangedEvent.
		  ToLayoutOrientationChangedEvent }
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget requestInnerConfiguration.
	anEvent currentTarget requestNewSkin
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget requestInnerConfiguration.
	anEvent currentTarget requestNewSkin
]
