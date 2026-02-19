Class {
	#name : #ToClickableEventHandler,
	#superclass : #BlBasicEventHandler,
	#category : #'Toplo-Widget-Button-Clickable'
}

{ #category : #'instance creation' }
ToClickableEventHandler class >> action: aBlock [

	^ self new action: aBlock
]

{ #category : #'api - event managing' }
ToClickableEventHandler >> handleEvent: anEvent [

	(anEvent isKindOf: anEvent currentTarget clickEventClass) ifFalse: [
		^ self ].
	anEvent currentTarget requestFocus.
	^ self
]

{ #category : #'api - event managing' }
ToClickableEventHandler >> wantsEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	^ target takeFocusOnClick and: [
		  anEvent isKindOf: target clickEventClass ]
]
