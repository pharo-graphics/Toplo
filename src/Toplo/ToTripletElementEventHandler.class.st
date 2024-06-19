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
		  BlLayoutConstraintsChangedEvent }
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutConstraintsChangedEvent: anEvent [

	anEvent currentTarget requestNewSkin
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
