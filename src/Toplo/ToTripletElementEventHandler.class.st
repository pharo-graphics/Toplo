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
		  ToLayoutOrientationChangedEvent.
		  BlLayoutResizerChangedEvent }
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget requestLayout.
	anEvent currentTarget requestNewSkin
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget requestLayout.
	anEvent currentTarget ensuredSkinManager requestInstallSkinIn: anEvent currentTarget
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestNewSkin
]
