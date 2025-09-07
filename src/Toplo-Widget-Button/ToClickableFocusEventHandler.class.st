Class {
	#name : #ToClickableFocusEventHandler,
	#superclass : #BlBasicEventHandler,
	#category : #'Toplo-Widget-Button-Clickable'
}

{ #category : #'instance creation' }
ToClickableFocusEventHandler class >> action: aBlock [

	^ self new action: aBlock
]

{ #category : #'api - event managing' }
ToClickableFocusEventHandler >> handleEvent: anEvent [

	(anEvent isKindOf: anEvent currentTarget clickEventClass) ifTrue: [
		anEvent currentTarget requestFocus ]
]

{ #category : #'api - event managing' }
ToClickableFocusEventHandler >> wantsEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	^ target takeFocusOnClick and: [
		  anEvent isKindOf: target clickEventClass ]
]
