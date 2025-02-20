Class {
	#name : #ToTabsElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'element events handling' }
ToTabsElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'api - accessing' }
ToTabsElementEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlLayoutResizerChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent }
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget configureLayout
]
