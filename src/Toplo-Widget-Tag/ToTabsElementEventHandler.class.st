Class {
	#name : #ToTabsElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #adding }
ToTabsElementEventHandler >> addButtonClickedEvent: anEvent [

	anEvent currentTarget addNewTagItem.
	anEvent consume
]

{ #category : #'api - accessing' }
ToTabsElementEventHandler >> eventsToHandle [

	^ { ToVisibleTabsChanged. BlLayoutResizerChangedEvent. ToAddButtonClickedEvent }
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestNewConfiguration
]

{ #category : #'element events handling' }
ToTabsElementEventHandler >> visibleTabsChanged: anEvent [

	anEvent currentTarget checkInvisibleNodes
]
