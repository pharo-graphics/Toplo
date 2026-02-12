Class {
	#name : #ToClickableEventHandler,
	#superclass : #BlBasicEventHandler,
	#category : #'Toplo-Widget-Button-Clickable'
}

{ #category : #'instance creation' }
ToClickableEventHandler class >> action: aBlock [

	^ self new action: aBlock
]

{ #category : #'mouse handlers' }
ToClickableEventHandler >> doubleClickEvent: anEvent [

	| target click |
	anEvent
		ifPrimary: [ ]
		secondary: [ ^ self ]
		middle: [ ^ self ]
		other: [ ^ self ].
	target := anEvent currentTarget.
	click := target clickEventClass new copyFrom: anEvent.
	click checked: target isChecked.
	target dispatchEvent: click
]

{ #category : #'api - event managing' }
ToClickableEventHandler >> handleEvent: anEvent [

	(anEvent isKindOf: anEvent currentTarget clickEventClass) ifTrue: [
			anEvent currentTarget requestFocus.
			^ self ].
	anEvent sendTo: self
]

{ #category : #'api - event managing' }
ToClickableEventHandler >> wantsEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	^ (target takeFocusOnClick and: [
		   anEvent isKindOf: target clickEventClass ]) or: [
		  anEvent isKindOf: BlDoubleClickEvent ]
]
