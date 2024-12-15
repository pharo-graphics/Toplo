Class {
	#name : #ToSegmentedElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'element events handling' }
ToSegmentedElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'api - accessing' }
ToSegmentedElementEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlLayoutResizerChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent }
]

{ #category : #'element events handling' }
ToSegmentedElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'element events handling' }
ToSegmentedElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'element events handling' }
ToSegmentedElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]
