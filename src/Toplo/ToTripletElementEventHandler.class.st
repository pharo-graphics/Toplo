Class {
	#name : #ToTripletElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'api - accessing' }
ToTripletElementEventHandler >> eventsToHandle [

	^ {
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
