Class {
	#name : #ToTabsElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'api - accessing' }
ToTabsElementEventHandler >> eventsToHandle [

	^ { ToVisibleTabsChanged. BlLayoutResizerChangedEvent }
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestNewConfiguration
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> visibleTabsChanged: anEvent [

	anEvent currentTarget checkInvisibleNodes
]
