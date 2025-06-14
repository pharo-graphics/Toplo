Class {
	#name : #ToTabGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #adding }
ToTabGroupElementEventHandler >> addButtonClickedEvent: anEvent [

	anEvent currentTarget addNewTabItem.
	anEvent consume
]

{ #category : #'api - accessing' }
ToTabGroupElementEventHandler >> eventsToHandle [

	^ {
		  ToVisibleTabsChanged.
		  BlLayoutResizerChangedEvent.
		  ToAddButtonClickedEvent }
]

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestNewConfiguration
]

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> visibleTabsChanged: anEvent [

	anEvent currentTarget checkInvisibleNodes
]
