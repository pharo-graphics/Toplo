Class {
	#name : #ToLabeledIconEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core'
}

{ #category : #'api - accessing' }
ToLabeledIconEventHandler >> eventsToHandle [

	^ {
		  ToLayoutDirectionChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutConstraintsChangedEvent }
]

{ #category : #'events handling' }
ToLabeledIconEventHandler >> layoutConstraintsChangedEvent: anEvent [

	anEvent currentTarget requestNewSkin
]

{ #category : #'events handling' }
ToLabeledIconEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget requestNewSkin
]

{ #category : #'events handling' }
ToLabeledIconEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget ensuredSkinManager requestInstallSkinIn: anEvent currentTarget
]
