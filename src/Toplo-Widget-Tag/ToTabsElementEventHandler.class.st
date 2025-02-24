Class {
	#name : #ToTabsElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'api - accessing' }
ToTabsElementEventHandler >> eventsToHandle [

	^ { BlLayoutResizerChangedEvent }
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestInnerConfiguration
]
