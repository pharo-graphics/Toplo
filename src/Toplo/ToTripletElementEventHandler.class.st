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
		  ToLayoutConstraintsChangedEvent }
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutConstraintsChangedEvent: anEvent [

	anEvent currentTarget requestNewSkin
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget configureLayout.
	anEvent currentTarget requestNewSkin
]

{ #category : #'events handling' }
ToTripletElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget configureLayout.
	anEvent currentTarget ensuredSkinManager requestInstallSkinIn: anEvent currentTarget
]
